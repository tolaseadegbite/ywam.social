# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#  room_id    :bigint           not null
#
# Indexes
#
#  index_messages_on_account_id  (account_id)
#  index_messages_on_room_id     (room_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (room_id => rooms.id)
#
class Message < ApplicationRecord
  belongs_to :account
  belongs_to :room

  
  has_many_attached :attachments, dependent: :destroy
  
  def chat_attachment(index)
    target = attachments[index]
    return unless attachments.attached?
    
    if target.image?
      target.variant(resize_to_limit: [150, 150]).processed
    elsif target.video?
      target.variant(resize_to_limit: [150, 150]).processed
    end
  end
  
  after_create_commit { broadcast_append_to room }
  before_create :confirm_participant

  def confirm_participant
    return unless room.is_private

    is_participant = Participant.where(account_id: account.id, room_id: room.id).first
    throw :abort unless is_participant
  end
end
