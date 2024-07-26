class ForumsController < ApplicationController

  def index
    
  end

  def show
    @forum = Forum.includes(:account).find(params[:id])
  end
end
