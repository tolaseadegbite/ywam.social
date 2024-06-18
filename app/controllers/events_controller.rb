class EventsController < ApplicationController
    before_action :authenticate_account!
    before_action :find_event, only: [:show, :add_co_host, :remove_co_host, :accept_co_host, :decline_co_host]

    def index
      @events = Event.all
    end

    def show
      @event_talks = @event.event_talks.ordered
      @accounts = Account.all - @event.co_hosts
    end

    def add_co_host
      account = Account.find(params[:account_id])
      if account_declined_too_many_times?(account)
        redirect_to host_event_path(@event), alert: "This account has declined too many co-host invitations and cannot be added again."
      else
        if @event.add_co_host(account)
          redirect_to host_event_url(@event), notice: "Co-host added successfully."
        else
          redirect_to host_event_url(@event), alert: "Unable to add co-host."
        end
      end
    end
  
    def remove_co_host
      account = Account.find(params[:account_id])
      if @event.remove_co_host(account)
        redirect_to @event, notice: "Co-host removed successfully."
      else
        redirect_to @event, alert: "Unable to remove co-host."
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
        co_host.increment!(:decline_count)
        co_host.update(status: :declined)
        redirect_to @event, notice: "Co-host invitation declined."
      else
        redirect_to @event, alert: "Unable to decline co-host invitation."
      end
    end

    private

      def find_event
        @event ||= Event.includes(:co_hosts).find(params[:id])
      end
end
