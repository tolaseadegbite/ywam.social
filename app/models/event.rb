# == Schema Information
#
# Table name: events
#
#  id             :bigint           not null, primary key
#  details        :text
#  end_date       :date
#  end_time       :time
#  location       :string
#  name           :string
#  start_date     :date
#  start_time     :time
#  streaming_link :string
#  time_zone      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_events_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Event < ApplicationRecord
    # make sure the follwing event attributes are present before saving to database
    validates :name, :start_date, :start_time, :end_date, :end_time, :time_zone, :details, :location, :streaming_link, presence: true

    # associate event to a user
    belongs_to :user
end
