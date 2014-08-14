class CommentsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(comment_params)
		@comment.user = current_user
		@comment.save
		redirect_to post_path(@post)
	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to post_path(@post)
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end

	def correct_user
		@post = Post.find(params[:post_id])
		@all = @post.user
  		unless current_user?(@all)
  			flash[:notice] = "You are not authorized." 
  			redirect_to root_url
  		end	
  	end

end