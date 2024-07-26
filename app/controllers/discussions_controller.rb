class DiscussionsController < ApplicationController
  before_action :authenticate_account!, except: %i[ index show ]
  before_action :set_discussion, only: %i[ show edit update destroy ]
  before_action :set_forum, except: :index

  def index
    @discussions = Discussion.all
    @forums = Forum.all
  end

  def show
    @commentable = @discussion
    @comment = Comment.new
    @comments = @discussion.comments
  end

  def new
    @discussion = Discussion.new
  end

  def edit
  end

  def create
    @discussion = @forum.discussions.build(discussion_params)
    @discussion.account = current_account

    respond_to do |format|
      if @discussion.save
        format.html { redirect_to discussion_url(@discussion), notice: "Discussion was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @discussion.update(discussion_params)
        format.html { redirect_to discussion_url(@discussion), notice: "Discussion was successfully updated." }
      else
        format.html render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @discussion.destroy!

    respond_to do |format|
      format.html { redirect_to discussions_url, notice: "Discussion was successfully destroyed." }
    end
  end

  private
    def set_discussion
      @discussion = Discussion.find(params[:id])
    end

    def set_forum
      @forum = Forum.find(params[:forum_id])
    end

    def discussion_params
      params.require(:discussion).permit(:title, :body, :forum_id, :account_id)
    end
end
