class ApplicationController < ActionController::Base

before_action :current_user

  def current_user
    @current_user = User.find_by(id: session[:user_id]) 
  end

  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ゲーマー登録が必要じゃ！"
      redirect_to("/")
    end
  end

  def forbid_login_user
    if @current_user
    flash[:notice] = "もうログインしておるぞ！"
    redirect_to("/")
    end
  end
end
