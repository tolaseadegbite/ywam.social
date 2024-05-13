class AccountsController < ApplicationController

  def show
    @account = Account.find(params[:id])
    @accounts = Account.all_except(current_account)

    @room = Room.new
    @rooms = Room.public_rooms
    @room_name = get_name(@account, current_account)
    @single_room = Room.where(name: @room_name).first || Room.create_private_room([@account, current_account], @room_name)

    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)
    render 'rooms/index'
  end

  private

    def get_name(account1, account2)
      account = [account1, account2].sort
      "private_#{account[0].id}_#{account[1].id}"
    end
end
