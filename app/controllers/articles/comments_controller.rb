module Articles
    class CommentsController < CommentsController
        private

        def set_commentable
            @commentable = Article.find(params[:article_id])
        end
    end
end