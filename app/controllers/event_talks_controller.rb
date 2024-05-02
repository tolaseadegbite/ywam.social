class EventTalksController < ApplicationController
    before_action :authenticate_user!
    before_action :find_event_talk, only: [:show, :edit, :update, :destroy]
    # before_action :find_event_speaker

    def show
      
    end

    def edit
      
    end

    def update
      
    end

    def destroy
      
    end

    private

        def event_talk_params
          param.require(:event_talk).permit(:title, :description)
        end

        def find_event_talk
          @event_talk ||= EventTalk.find(params[:id])
        end

        # def find_event_speaker
        #   @event_speaker ||= EventSpeaker.find(params[:event_speaker_id])
        # end
end
