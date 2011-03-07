class RepliesController < ApplicationController
  load_and_authorize_resource
  before_filter :get_comment
  
  def get_comment
    @comment = Comment.find(params[:comment_id])
    @post = find_commentable
    @opening  = find_commentable
  end
  
  def new
    @reply = @comment.replies.build
  end

  def create
    @reply = @comment.replies.build(params[:reply])
    if current_user != nil
      @reply.user_id = current_user.id
    end

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
   
   private
   
   def find_commentable  
     params.each do |name, value|  
       if name =~ /(.+)_id$/  
         return $1.classify.constantize.find(value)  
       end  
     end  
     nil  
   end
end
