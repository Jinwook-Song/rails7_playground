class Post < ApplicationRecord
  belongs_to :employee
  
  # 💎 캐시 무효화 콜백 (Rails 8 권장 패턴)
  after_create :invalidate_employee_cache
  after_update :invalidate_employee_cache
  after_destroy :invalidate_employee_cache
  
  private
  
  def invalidate_employee_cache
    Rails.cache.delete_matched("employee_#{employee_id}_posts_*")
    Rails.logger.info "🗑️ Employee #{employee_id} Posts 캐시 무효화"
  end
end
