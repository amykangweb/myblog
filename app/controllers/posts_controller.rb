class PostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def home
    @post = Post.where(:private => false)
    @posts = @post.all(limit: 6)
  end

  def show
  	@post = Post.find(params[:id])
    @user = @post.user
    @all = @user.posts.where(:private => false)
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
  		render 'show'
  	end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "Your post has been updated."
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
  	@post.destroy
  	redirect_to current_user
  end

  private

  def post_params
  	params.require(:post).permit(:title, :content, :private)
  end

  def correct_user
  	@post = current_user.posts.find_by(id: params[:id])
  	redirect_to root_url if @post.nil?
  end
end