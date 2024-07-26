# == Schema Information
#
# Table name: forums
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :bigint           not null
#
# Indexes
#
#  index_forums_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Forum < ApplicationRecord
  belongs_to :account

  has_many :discussions, dependent: :destroy
end
