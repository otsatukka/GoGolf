class RepliesController < ApplicationController
  before_filter :get_comment
  
  def get_comment
    @comment = Comment.find(params[:comment_id])
    @post = Post.find(params[:post_id])
  end
  
  def new
    @reply = @comment.replies.build
  end

  def create
    @reply = @comment.replies.build(params[:reply])

    if @reply.save
      respond_to do |format|
        #format.html { redirect_to @post, :notice => 'Thank you for your comment!' }
        format.js 
      end
    else
      render :new
    end
  end
  
  def destroy
     @reply = Reply.find(params[:id])
     @reply.destroy
     respond_to do |format|
       format.html { redirect_to @post }
       format.js 
     end
   end
end
