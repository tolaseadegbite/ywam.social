class Host::EventSpeakersController < ApplicationController
    before_action :authenticate_account!
    before_action :find_event
    before_action :find_event_speaker, only: [:show, :edit, :update, :destroy]

    def create
      @event_speaker = @event.event_speakers.build(event_speaker_params)
      @event_speaker.account = current_account

        if @event_speaker.save
            respond_to do |format|
                format.html { redirect_to host_event_event_speaker_url(@event, @event_speaker), notice: 'Event Speaker was successfully created' }
            end
        end
    end

    def show
      @event_talks = @event_speaker.event_talks
      @event_talk = EventTalk.new
    end

    def edit 
      
    end

    def update
      
    end

    def destroy
      
    end

    private

        def event_speaker_params
          params.require(:event_speaker).permit(:name, :about)
        end

        def find_event_speaker
          @event_speaker = EventSpeaker.find(params[:id])
        end

        def find_event
          @event = Event.find(params[:event_id])
        end
end
