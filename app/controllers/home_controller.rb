class HomeController < ApplicationController

  before_action :authenticate_user, {only: [:thread_creation, :thread_create]}

  def top
    @posts = Post.paginate(page: params[:page], per_page: 10).order(updated_at: "desc")
  end

  def thread_creation
    @post = Post.new
  end

  def thread_create
    @post = Post.new(
      game_name: params[:game_name],
      thread_name: params[:thread_name])
    if @post.save
      flash[:notice] = "集会場が出来たぞ！"
      redirect_to("/")
    else
      flash[:notice] = "どっちも入力するのじゃ"
      render("home/thread_creation")
    end
  end

  def login
    @user = User.find_by(user_name: params[:user_name])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "#{@user.user_name}！おかえり！"
      redirect_to("/")
    else
      flash[:notice] = "ゲーマーが存在しないぞ・・・ゲーマー登録をするのじゃ！"
      redirect_to("/")
    end
  end
end
