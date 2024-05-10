class MessagesController < ApplicationController
    before_action :authenticate_account!

    def create
      @message = current_account.messages.create(body: msg_params[:body], room_id: params[:room_id])
    end

    private

        def msg_params
          params.require(:message).permit(:body)
        end
end
