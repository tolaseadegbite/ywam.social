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
class EventSpeaker < ApplicationRecord
  # associate event speaker to the following objects
  belongs_to :user
  belongs_to :event

  # associate event speaker to the following objects and destoy them when the event speaker is deleted from the database
  has_many :event_talks, dependent: :destroy
  has_many :speaker_profiles, dependent: :destroy
end
