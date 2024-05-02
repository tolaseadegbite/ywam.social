# == Schema Information
#
# Table name: event_speakers
#
#  id         :bigint           not null, primary key
#  about      :text
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#  event_id   :bigint           not null
#
# Indexes
#
#  index_event_speakers_on_account_id  (account_id)
#  index_event_speakers_on_event_id    (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (event_id => events.id)
#
require "test_helper"

class EventSpeakerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
