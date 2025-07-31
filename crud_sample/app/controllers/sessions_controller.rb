class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "로그인되었습니다."
      redirect_to root_path
    else
      flash.now[:alert] = "이메일 또는 비밀번호가 잘못되었습니다."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "로그아웃되었습니다."
    redirect_to root_path
  end
end
