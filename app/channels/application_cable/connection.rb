module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # This is supposed to be "current_account" but for some reason, current_user is what worked
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      
      if verified_user = env['warden'].user
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end