class Host::EventsController < ApplicationController
    before_action :authenticate_account!
    before_action :find_event, only: [:show, :edit, :update, :destroy, :add_co_host, :remove_co_host, :accept_co_host, :decline_co_host]
    before_action :find_correct_account, only: [:show, :edit, :update, :destroy]
    before_action :find_event_category

    def index
      @events = Event.all
    end

    def show
      @event_talks = @event.event_talks.ordered
      @accounts = Account.all - @event.co_hosts
    end

    def new
      @event = Event.new event_params
    end

    def create
        @event = current_account.events.build(event_params)
        if @event.save
          respond_to do |format|
            format.html { redirect_to host_event_url(@event), notice: 'Event was successfully created' }
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
          format.html { redirect_to host_event_url(@event), notice: 'Event was successfully updated' }
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @event.destroy
      respond_to do |format|
        format.html { redirect_to host_events_url, notice: 'Event was successfully deleted' }
      end
    end

    def add_co_host
      account = Account.find(params[:account_id])
      if @event.add_co_host(account)
        redirect_to host_event_url(@event), notice: "Co-host added successfully."
      else
        redirect_to host_event_url(@event), alert: "Unable to add co-host."
      end
    end
  
    def remove_co_host
      account = Account.find(params[:account_id])
      if @event.remove_co_host(account)
        redirect_to host_event_url(@event), notice: "Co-host removed successfully."
      else
        redirect_to host_event_url(@event), alert: "Unable to remove co-host."
      end
    end

    def accept_co_host
      co_host = @event.event_co_hosts.find_by(account_id: params[:account_id])
      if co_host&.pending?
        co_host.update(status: :accepted)
        redirect_to @event, notice: "Co-host invitation accepted."
      else
        redirect_to @event, alert: "Unable to accept co-host invitation."
      end
    end
  
    def decline_co_host
      co_host = @event.event_co_hosts.find_by(account_id: params[:account_id])
      if co_host&.pending?
        co_host.update(status: :declined)
        redirect_to @event, notice: "Co-host invitation declined."
      else
        redirect_to @event, alert: "Unable to decline co-host invitation."
      end
    end

    private

      def event_params
        params.fetch(:event, {}).permit(:name, :start_date, :start_time, :end_date, :end_time, :details, :streaming_link, :time_zone, :event_category_id, :event_type, :cost_type, :country, :state, :city, :street_address)
      end

      def find_event
        @event ||= Event.find(params[:id])
      end

      def find_event_category
      #   @event_category ||= @event.event_category.find(params[:event_category_id])
      end

      def find_correct_account
        @event ||= Event.find(params[:id])
        redirect_to(events_url, status: :see_other, notice: 'Access Denied') unless current_account == @event.account  
      end
end
