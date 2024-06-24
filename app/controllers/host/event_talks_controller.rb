class Host::EventTalksController < ApplicationController
    before_action :authenticate_account!
    before_action :find_event
    before_action :find_event_speaker
    before_action :find_event_talk, only: [:show, :edit, :update, :destroy]

    def show
      
    end

    def create
      @event_talk = @event_speaker.event_talks.build(event_talk_params)
      @event_talk.account = current_account
      @event_talk.event = @event # Associate the event talk with the event

      if @event_talk.save
        redirect_to host_event_event_speaker_event_talk_url(@event, @event_speaker, @event_talk), notice: 'Event talk was successfully created'
      else
        redirect_to host_event_event_speaker_url(@event, @event_speaker), notice: @event_talk.errors.full_messages.to_sentence
        # flash[:notice] = @event_talk.errors.full_messages.to_sentence
      end
    end

    def edit
      
    end

    def update
      
    end

    def destroy
      
    end

    private

        def event_talk_params
          params.require(:event_talk).permit(:title, :description)
        end

        def find_event_talk
          @event_talk = EventTalk.find(params[:id])
        end

        def find_event_speaker
          @event_speaker = EventSpeaker.find(params[:event_speaker_id])
        end

        def find_event
          @event = Event.find(params[:event_id])
        end
end
