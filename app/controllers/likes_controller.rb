class LikesController < ApplicationController
  before_action :authenticate_account!

  def create
    @like = current_account.likes.new(likes_params)

    if @like.save
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path, notice: "#{@like.likeable_type} liked") }
        # format.turbo_stream { flash.now[:notice] = 'Episode liked' }
      end
    else
      flash[:notice] = @like.errors.full_messages.to_sentence
    end
  end

  def destroy
    @like = current_account.likes.find(params[:id])
    likeable = @like.likeable
    @like.destroy

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path, notice: "#{@like.likeable_type} unliked") }
      # format.turbo_stream { flash.now[:notice] = 'Episode unliked' }
    end
  end

  private

  def likes_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
