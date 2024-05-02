# == Schema Information
#
# Table name: speaker_profiles
#
#  id               :bigint           not null, primary key
#  link             :string
#  name             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  account_id       :bigint           not null
#  event_speaker_id :bigint           not null
#
# Indexes
#
#  index_speaker_profiles_on_account_id        (account_id)
#  index_speaker_profiles_on_event_speaker_id  (event_speaker_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (event_speaker_id => event_speakers.id)
#
class SpeakerProfile < ApplicationRecord
  belongs_to :event_speaker
  belongs_to :account
end
