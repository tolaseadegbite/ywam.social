class StaticPagesController < ApplicationController
  after_action :set_status

  def home
  end

  def about
  end

  def help
  end

  private
  def set_status
    current_account.update!(status: Account.statuses[:offline]) if current_account
  end
end
