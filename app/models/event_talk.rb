# == Schema Information
#
# Table name: event_talks
#
#  id               :bigint           not null, primary key
#  description      :text
#  title            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  event_id         :bigint           not null
#  event_speaker_id :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_event_talks_on_event_id          (event_id)
#  index_event_talks_on_event_speaker_id  (event_speaker_id)
#  index_event_talks_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (event_speaker_id => event_speakers.id)
#  fk_rails_...  (user_id => users.id)
#
class EventTalk < ApplicationRecord
  # associate event talk to the following objects
  belongs_to :user
  belongs_to :event
  belongs_to :event_speaker

  scope :ordered, -> { order(id: :desc) }
end
