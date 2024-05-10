class ProfilesController < ApplicationController
    before_action :authenticate_account!

    def show
      
    end

    def update
      
    end

    private

        def find_account
          @account = Account.find_by(params[:username])
        end
end
