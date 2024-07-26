class BookmarksController < ApplicationController
  before_action :authenticate_account!

  def create
    @bookmark = current_account.bookmarks.new(bookmarks_params)

    if @bookmark.save
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path, notice: "#{@bookmark.bookmarkable_type} bookmarked") }
        # format.turbo_stream { flash.now[:notice] = 'Episode bookmarkd' }
      end
    else
      flash[:notice] = @bookmark.errors.full_messages.to_sentence
    end
  end

  def destroy
    @bookmark = current_account.bookmarks.find(params[:id])
    # bookmarkable = @bookmark.bookmarkable
    @bookmark.destroy

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path, notice: "#{@bookmark.bookmarkable_type} unbookmarked") }
      # format.turbo_stream { flash.now[:notice] = 'Episode unbookmarkd' }
    end
  end

  private

  def bookmarks_params
    params.require(:bookmark).permit(:bookmarkable_id, :bookmarkable_type)
  end
end
