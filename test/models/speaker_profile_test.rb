# == Schema Information
#
# Table name: speaker_profiles
#
#  id               :bigint           not null, primary key
#  link             :string
#  name             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  event_speaker_id :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_speaker_profiles_on_event_speaker_id  (event_speaker_id)
#  index_speaker_profiles_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_speaker_id => event_speakers.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class SpeakerProfileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
