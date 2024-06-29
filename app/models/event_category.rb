# == Schema Information
#
# Table name: event_categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#
# Indexes
#
#  index_event_categories_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class EventCategory < ApplicationRecord

    # make sure the follwing event_category attributes are present before saving to database
    validates :name, presence: true

    # associates event category to account
    belongs_to :account

    has_many :events, dependent: :destroy
end
