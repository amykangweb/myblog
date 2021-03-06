class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :dash]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def dash
    @user = User.find_by(params[:id])
    @posts = current_user.posts.paginate(page: params[:page])
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Update Successful."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
      @user = User.find(params[:id])
      @all = @user.posts.where(:private => false)
      @posts = @all.paginate(page: params[:page])
  end

  def new
  	@user = User.new
    if signed_in?
      flash[:notice] = "You are already signed in."
      redirect_to current_user
    end
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		sign_in @user
  		flash[:success] = "Welcome to MyBlog."
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to user_url
  end

  private

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def correct_user
    @user = User.find_by(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

end
