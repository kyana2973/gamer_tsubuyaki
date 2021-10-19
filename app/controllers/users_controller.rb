class UsersController < ApplicationController

  before_action :authenticate_user, {only: [:logout]}
  before_action :forbid_login_user, {only: [:signup, :users_signup]}
  before_action :ensure_correct_user, {only: [:update_form, :update, :destroy, :back]}

  def signup
    @user = User.new
    if @current_user
      flash[:notice] = "すでにログインしておるぞ！"
      redirect_to("/")
    end
  end

  def users_signup
    @user = User.new(
      user_name: params[:user_name],
      password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ようこそ！ゲーつぶの世界へ！"
      redirect_to("/users/#{@user.id}")
    else
      flash[:notice] = "同じ名前のゲーマーがいるようじゃ・・・"
      render("users/signup")
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def updateform
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.user_name = params[:user_name]
    @user.introduction = params[:introduction]

    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end

    if @user.save
      flash[:notice] = "編集完了じゃ！"
      redirect_to("/users/#{@user.id}")
    else
      render("users/update_form")
    end

  end

  def back
    @user = User.find_by(id: params[:id])
    redirect_to("/users/#{@user.id}")
  end

  def logout
    if session[:user_id]
      session[:user_id] = nil
      flash[:notice] = "ログアウト〜またな！"
      redirect_to("/")
    else
      flash[:notice] = "ログインしとらんぞ〜？"
      redirect_to("/")
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    
    if @user.destroy
      session[:user_id] = nil
      flash[:notice] = "さらばじゃ・・・"
      redirect_to("/")
    end
  end

  def ensure_correct_user
    if @current_user.id =! params[:id].to_i
      flash[:notice] = "お主には権限が無いぞ！"
      redirect_to("/users/#{params[:id]}")
    end
  end

end
