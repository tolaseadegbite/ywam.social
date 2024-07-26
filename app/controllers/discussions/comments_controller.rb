module Discussions
  class CommentsController < CommentsController
    private

    def set_commentable
      @commentable = Discussion.find(params[:discussion_id])
    end
  end
end