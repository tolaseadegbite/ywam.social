class EventsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_event, only: [:show, :edit, :update, :destroy]
    before_action :find_correct_user, only: [:show, :edit, :update, :destroy]
    before_action :find_event_category

    def index
      @events = Event.all
    end

    def show
      @event_talks = @event.event_talks.ordered
    end

    def new
      @event = Event.new
    end

    def create
        @event = current_user.events.build(event_params)
        if @event.save
          respond_to do |format|
            format.html { redirect_to @event, notice: 'Event was successfully created' }
          end
        else
          render :new, status: :unprocessable_entity
        end
    end

    def edit
      
    end

    def update
      if @event.update(event_params)
        respond_to do |format|
          format.html { redirect_to @event, notice: 'Event was successfully updated' }
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @event.destroy
      respond_to do |format|
        format.html { redirect_to events_url, notice: 'Event was successfully deleted' }
      end
    end

    private

        def event_params
          params.require(:event).permit(:name, :start_date, :start_time, :end_date, :end_time, :details, :streaming_link, :time_zone, :event_category_id, :location, :event_type, :cost_type)
        end

        def find_event
          @event ||= Event.find(params[:id])
        end

        def find_event_category
        #   @event_category ||= @event.event_category.find(params[:event_category_id])
        end

        def find_correct_user
          @event ||= Event.find(params[:id])
          redirect_to(events_url, status: :see_other, notice: 'Access Denied') unless current_user == @event.user  
        end
end
