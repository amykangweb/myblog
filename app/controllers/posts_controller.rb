class PostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def home
    @posts = Post.all(limit: 6)
  end

  def show
  	@post = Post.find(params[:id])
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = current_user.posts.build(post_params)
  	if @post.save
  		flash[:success] = "Post created!"
  		redirect_to current_user
  	else
      @feed_items = []
  		render 'users/show'
  	end
  end

  def destroy
  	@post.destroy
  	redirect_to current_user
  end

  private

  def post_params
  	params.require(:post).permit(:title, :content)
  end

  def correct_user
  	@post = current_user.posts.find_by(id: params[:id])
  	redirect_to root_url if @post.nil?
  end
end