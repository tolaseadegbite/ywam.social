# == Schema Information
#
# Table name: event_categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_event_categories_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class EventCategory < ApplicationRecord

    # make sure the follwing event_category attributes are present before saving to database
    validates :name, presence: true

    # associates event category to user
    belongs_to :user
end
