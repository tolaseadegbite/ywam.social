module Inboxes
    class CommentsController < CommentsController
        private

        def set_commentable
            @commentable = Inbox.find(params[:inbox_id])
        end
    end
end