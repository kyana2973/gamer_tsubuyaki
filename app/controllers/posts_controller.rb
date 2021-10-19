class PostsController < ApplicationController

  before_action :authenticate_user, {only: [:tweet]}

  def thread_show
    @post = Post.find_by(id: params[:id])
    @tweets = Tweet.paginate(page: params[:page], per_page: 20).where(thread_id: @post.id).order(created_at: "desc")
  end

  def tweet
    @tweet = Tweet.new(
      thread_id: params[:id],
      user_id: @current_user.id,
      tweet: params[:tweet]
    )
    
    if @tweet.save
      flash[:notice] = "つぶやいたぞ〜"
      redirect_to("/posts/#{@tweet.thread_id}")
    end

  end

  def tweet_destroy
    @tweet = Tweet.find_by(id: params[:id])
    if @tweet.destroy
      flash[:notice] = "つぶやきを削除したぞ〜"
      redirect_to("/posts/#{@tweet.thread_id}")
    end
  end

end
