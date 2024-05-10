class RoomsController < ApplicationController
  before_action :authenticate_account!

  def index
    @room = Room.new
    @rooms = Room.public_rooms
    @accounts = Account.all_except(current_account)

    render 'index'
  end
  
  def show
    @single_room = Room.find(params[:id])

    @room = Room.new
    @rooms = Room.public_rooms

    @message = Message.new
    @messages = @single_room.messages.order(id: :asc)

    @accounts = Account.all_except(current_account)

    render 'index'
  end

  def create
    @room = Room.create(name: params["room"]["name"])
  end

  private

    def room_params
      params.require(:room).permit(:name)
    end
end
