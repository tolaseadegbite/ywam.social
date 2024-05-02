# == Schema Information
#
# Table name: event_speakers
#
#  id         :bigint           not null, primary key
#  about      :text
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_event_speakers_on_event_id  (event_id)
#  index_event_speakers_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class EventSpeakerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
