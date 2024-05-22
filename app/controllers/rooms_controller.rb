class RoomsController < ApplicationController
  include RoomsHelper
  before_action :authenticate_account!
  before_action :set_status

  def index
    @room = Room.new
    @joined_rooms = current_account.joined_rooms.order('last_message_at DESC')
    @rooms = search_rooms
    
    @accounts = Account.all_except(current_account)

    render 'index'
  end
  
  def show
    @single_room = Room.find(params[:id])

    @room = Room.new
    @rooms = search_rooms
    @joined_rooms = current_account.joined_rooms.order('last_message_at DESC')

    @message = Message.new
    
    pagy_messages = @single_room.messages.includes(:account).order(id: :desc)
    @pagy, messages = pagy(pagy_messages, items: 20)
    @messages = messages.reverse

    @accounts = Account.all_except(current_account)

    render 'index'
  end

  def create
    @room = Room.create(name: params["room"]["name"])
    redirect_to @room, allow_other_host: true
  end

  def search
    @rooms = search_rooms
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update('search_results', 
          partial: 'rooms/search_results', 
          locals: {rooms: @rooms})
        ]
      end
    end
  end

  def join
    @room = Room.find(params[:id])
    current_account.joined_rooms << @room
    redirect_to @room, allow_other_host: true
  end

  def leave
    @room = Room.find(params[:id])
    current_account.joined_rooms.delete(@room)
    redirect_to rooms_url, allow_other_host: true
  end

  private

    def room_params
      params.require(:room).permit(:name)
    end

    def set_status
      current_account.update!(status: Account.statuses[:online]) if current_account
    end
end
