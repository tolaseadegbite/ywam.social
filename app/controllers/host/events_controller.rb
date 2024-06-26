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
      accepted_co_hosts = @event.event_co_hosts.accepted.map(&:account)
      declined_too_many_times = @event.event_co_hosts.where('decline_count > ?', 3).map(&:account)
      @accounts = Account.all - accepted_co_hosts - declined_too_many_times

      @event_speakers = @event.event_speakers
      @event_speaker = EventSpeaker.new
    end

    def new
      @event = Event.new event_params
    end

    def create
      @event = Event.new(event_params)
      @event.account = current_account
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
        redirect_to host_event_path(@event), notice: "Co-host invitation accepted."
      else
        redirect_to host_event_path(@event), alert: "Unable to accept co-host invitation."
      end
    end

    def decline_co_host
      co_host = @event.event_co_hosts.find_by(account_id: params[:account_id])
      if co_host&.pending?
        co_host.increment!(:decline_count)
        co_host.update(status: :declined)
        # NotificationJob.perform_later(@event.account, @event, "#{co_host.account.accountname} has declined the co-host invitation for the event: #{@event.name}", :co_host_declined)
        redirect_to host_event_path(@event), notice: "Co-host invitation declined."
      else
        redirect_to host_event_path(@event), alert: "Unable to decline co-host invitation."
      end
    end

    private

      def event_params
        params.fetch(:event, {}).permit(:name, :start_date, :start_time, :end_date, :end_time, :details, :streaming_link, :time_zone, :event_category_id, :event_type, :cost_type, :country, :state, :city, :street_address, :status)
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
