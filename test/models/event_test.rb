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
require "test_helper"

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
