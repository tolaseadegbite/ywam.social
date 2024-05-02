# == Schema Information
#
# Table name: events
#
#  id                :bigint           not null, primary key
#  cost_type         :integer
#  details           :text
#  end_date          :date
#  end_time          :time
#  event_type        :integer
#  location          :string
#  name              :string
#  start_date        :date
#  start_time        :time
#  streaming_link    :string
#  time_zone         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  event_category_id :bigint           not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_events_on_event_category_id  (event_category_id)
#  index_events_on_user_id            (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_category_id => event_categories.id)
#  fk_rails_...  (user_id => users.id)
#
class Event < ApplicationRecord
    # make sure the follwing event attributes are present before saving to database
    validates :name, :start_date, :start_time, :time_zone, :details, :location, :streaming_link, :event_type, :cost_type, presence: true

    # associate event to a user
    belongs_to :user

    # associate the follwing objects to an event and also delete from database when the event is destroyed
    has_many :event_speakers, dependent: :destroy
    has_many :event_talks, dependent: :destroy

    # event types
    enum event_type: {
        online: 0,
        'in-person': 1
    }

    # cost type options
    enum cost_type: {
        free: 0,
        paid: 1
    }
end
