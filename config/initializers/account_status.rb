module YwamSocial
    class AccountStatus < Application
      config.after_initialize do
        connection = ActiveRecord::Base.connection
        if connection.table_exists?('accounts') && connection.column_exists?('accounts', 'status')
          Account.update_all(status: Account.statuses[:offline])
        end
      rescue StandardError
        puts 'Account statuses not updated'
      end
    end
end