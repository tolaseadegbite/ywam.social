class EventsController < ApplicationController
    before_action :authenticate_account!
    before_action :find_event, only: [:show, :add_co_host, :remove_co_host, :accept_co_host, :decline_co_host]

    def index
      @events = Event.all
    end

    def show
      @event_talks = @event.event_talks.ordered
      accepted_co_hosts = @event.event_co_hosts.accepted.map(&:account)
      declined_too_many_times = @event.event_co_hosts.where('decline_count > ?', 3).map(&:account)
      @accounts = Account.all - accepted_co_hosts - declined_too_many_times
    end

    def add_co_host
      account = Account.find(params[:account_id])
      co_host = @event.event_co_hosts.find_or_initialize_by(account: account)

      if co_host.decline_count > 3
        redirect_to host_event_path(@event), alert: "This account has declined too many co-host invitations and cannot be added again."
      else
        co_host.status = :pending
        if co_host.save
          # NotificationJob.perform_later(account, @event, "You have been added as a co-host to the event: #{@event.name}", :co_host_added)
          redirect_to host_event_path(@event), notice: "Co-host added successfully."
        else
          redirect_to host_event_path(@event), alert: "Unable to add co-host."
        end
      end
    end

    def remove_co_host
      account = Account.find(params[:account_id])
      co_host = @event.event_co_hosts.find_by(account: account)
      if co_host&.destroy
        # NotificationJob.perform_later(account, @event, "You have been removed as a co-host from the event: #{@event.name}", :co_host_removed)
        redirect_to host_event_path(@event), notice: "Co-host removed successfully."
      else
        redirect_to host_event_path(@event), alert: "Unable to remove co-host."
      end
    end

    def accept_co_host
      co_host = @event.event_co_hosts.find_by(account_id: params[:account_id])
      if co_host&.pending?
        co_host.update(status: :accepted)
        # NotificationJob.perform_later(@event.account, @event, "#{co_host.account.accountname} has accepted the co-host invitation for the event: #{@event.name}", :co_host_accepted)
        redirect_to event_path(@event), notice: "Co-host invitation accepted."
      else
        redirect_to event_path(@event), alert: "Unable to accept co-host invitation."
      end
    end

    def decline_co_host
      co_host = @event.event_co_hosts.find_by(account_id: params[:account_id])
      if co_host&.pending?
        co_host.increment!(:decline_count)
        co_host.update(status: :declined)
        # NotificationJob.perform_later(@event.account, @event, "#{co_host.account.accountname} has declined the co-host invitation for the event: #{@event.name}", :co_host_declined)
        redirect_to event_path(@event), notice: "Co-host invitation declined."
      else
        redirect_to event_path(@event), alert: "Unable to decline co-host invitation."
      end
    end

    private

      def find_event
        @event ||= Event.includes(:co_hosts).find(params[:id])
      end
end
