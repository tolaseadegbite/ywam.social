class FollowsController < ApplicationController
  before_action :authenticate_account!

  def create
    @follow = current_account.follows.new(follows_params)

    if @follow.save
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path, notice: "#{@follow.followable_type} followed") }
        # format.turbo_stream { flash.now[:notice] = 'Episode followd' }
      end
    else
      flash[:notice] = @follow.errors.full_messages.to_sentence
    end
  end

  def destroy
    @follow = current_account.follows.find(params[:id])
    # followable = @follow.followable
    @follow.destroy

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path, notice: "#{@follow.followable_type} unfollowed") }
      # format.turbo_stream { flash.now[:notice] = 'Episode unfollowd' }
    end
  end

  private

  def follows_params
    params.require(:follow).permit(:followable_id, :followable_type)
  end
end
