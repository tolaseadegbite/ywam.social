class EventsController < ApplicationController
    before_action :authenticate_account!
    before_action :find_event, only: [:show]

    def index
      @events = Event.all
    end

    def show
      @event_talks = @event.event_talks.ordered
    end

    private

      def find_event
        @event ||= Event.find(params[:id])
      end
end
