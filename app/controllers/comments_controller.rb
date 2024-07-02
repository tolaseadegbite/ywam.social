class CommentsController < ApplicationController
    before_action :set_commentable
  
    def new
      @comment = Comment.new
    end
  
    def create
      @comment = @commentable.comments.build(comment_params)
      if @comment.save
        redirect_to @commentable unless @commentable.is_a?(Comment)
        redirect_to @commentable.find_top_parent if @commentable.is_a?(Comment)
        flash[:notice] = 'Comment created'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def destroy
      @comment = Comment.find(params[:id])
      if @comment.destroy
        redirect_to @commentable unless @commentable.is_a?(Comment)
        redirect_to @commentable.find_top_parent if @commentable.is_a?(Comment)
        flash[:notice] = 'Comment deleted'
      else
        redirect_to @commentable, alert: 'Something went wrong'
      end
    end
  
    private
  
    # not very nice, in my opinion
    # def set_commentable
    #   if params[:inbox_id].present?
    #     @commentable = Inbox.find(params[:inbox_id])
    #   elsif params[:comment_id]
    #     @commentable = Comment.find(params[:comment_id])
    #   else
    #     "SOME ERROR"
    #   end
    # end
  
    def comment_params
      params.require(:comment).permit(:body).merge(account: current_account)
    end
  end