module PrayerRequests
    class CommentsController < CommentsController
        private

        def set_commentable
            @commentable = PrayerRequest.find(params[:prayer_request_id])
        end
    end
end