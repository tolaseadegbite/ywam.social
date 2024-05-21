class AccountsController < ApplicationController
  include RoomsHelper
  before_action :authenticate_account!
  def show
    @account = Account.find(params[:id])
    @accounts = Account.all_except(current_account)

    @room = Room.new
    @joined_rooms = current_account.joined_rooms
    @rooms = search_rooms
    @room_name = get_name(@account, current_account)
    @single_room = Room.where(name: @room_name).first || Room.create_private_room([@account, current_account], @room_name)

    @message = Message.new

    pagy_messages = @single_room.messages.includes(:account).order(id: :desc)
    @pagy, messages = pagy(pagy_messages, items: 20)
    @messages = messages.reverse
    
    render 'rooms/index'
  end

  private

    def get_name(account1, account2)
      account = [account1, account2].sort
      "private_#{account[0].id}_#{account[1].id}"
    end
end
