class CommentsController < ApplicationController
  before_filter :get_commentable, :only => [:new, :create, :destroy]
  
  authorize_resource
  
  def vote_up
    begin
      current_user.vote_for(@comment = Comment.find(params[:id]))
      respond_to do |format|
        format.js 
      end
    rescue ActiveRecord::RecordInvalid
      render :nothing => true, :status => 404
    end
  end
  
  def get_commentable
    @commentable = find_commentable
  end
  
  def new
    @comment = @commentable.comments.build
    @comment.replies.build
  end

  def create
    @comment = @commentable.comments.build(params[:comment])
    @post = @commentable
    if current_user != nil
      @comment.user_id = current_user.id
    end

    if @comment.save
      respond_to do |format|
        format.js 
      end
    else
      render :new
    end
  end
  
  def destroy
     @comment = Comment.find(params[:id])
     @post = @commentable
     @comment.destroy
     respond_to do |format|
       format.html { redirect_to comments_path }
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
