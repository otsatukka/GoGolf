class CommentsController < ApplicationController
  before_filter :get_post
  
  def get_post
    @post = Post.find(params[:post_id])
  end
  
  def new
    @comment = @post.comments.build
    @comment.replies.build
  end

  def create
    @comment = @post.comments.build(params[:comment])
    if current_user != nil
      @comment.user_id = current_user.id
    end

    if @comment.save
      respond_to do |format|
        #format.html { redirect_to @post, :notice => 'Thank you for your comment!' }
        format.js 
      end
    else
      render :new
    end
  end
  
  def destroy
     @comment = Comment.find(params[:id])
     @comment.destroy
     respond_to do |format|
       format.html { redirect_to comments_path }
       format.js 
     end
   end
end
