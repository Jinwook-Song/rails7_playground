class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show edit update destroy posts ]

  def index
    @employees = Employee.all
  end

  def show
    # posts는 별도로 로드하지 않음
    Rails.logger.info "🔍 Employee Show 액션 실행 - ID: #{params[:id]}"
  end

  def posts
    Rails.logger.info "📝 Posts 액션 실행 - Employee ID: #{@employee.id}"
    
    # 시작 시간 기록
    start_time = Time.current
    
    # 💎 Solid Cache 사용한 스마트 캐싱
    cache_key = "employee_#{@employee.id}_posts_#{@employee.updated_at.to_i}"
    
    @posts = Rails.cache.fetch(cache_key, expires_in: 5.minutes) do
      Rails.logger.info "🔥 캐시 미스 - 데이터베이스에서 조회"
      @employee.posts.order(created_at: :desc).to_a
    end
    
    if Rails.cache.exist?(cache_key)
      Rails.logger.info "⚡ 캐시 히트 - 메모리에서 조회"
    end
    
    Rails.logger.info "📊 Posts 개수: #{@posts.count}"
    
    # 경과 시간 계산
    elapsed_time = Time.current - start_time
    minimum_delay = 3.0 # 최소 3초
    
    # 3초에 미달하면 남은 시간만큼 추가 대기
    if elapsed_time < minimum_delay
      additional_wait = minimum_delay - elapsed_time
      Rails.logger.info "⏱️ 추가 대기 시간: #{additional_wait.round(2)}초"
      sleep(additional_wait)
    else
      Rails.logger.info "⚡ 쿼리 시간이 3초 이상: #{elapsed_time.round(2)}초"
    end
    
    # 💎 HTTP 캐싱 헤더 추가 (Rails 8 권장)
    expires_in 5.minutes, public: true
    
    render partial: 'posts', locals: { posts: @posts }
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      redirect_to @employee, notice: "Employee was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @employee.update(employee_params)
      # 💎 캐시 무효화 (employee 업데이트 시)
      Rails.cache.delete_matched("employee_#{@employee.id}_posts_*")
      redirect_to @employee, notice: "Employee was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # 💎 캐시 무효화 (employee 삭제 시)
    Rails.cache.delete_matched("employee_#{@employee.id}_posts_*")
    @employee.destroy
    redirect_to employees_url, notice: "Employee was successfully destroyed.", status: :see_other
  end

  private
    def set_employee
      # show 액션에서는 posts 로드하지 않음
      @employee = Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit(:firstname, :lastname, :email, :phone, :has_passport, :salary, :notes, :birth_date, :hire_date, :gender)
    end
end
