# == Schema Information
#
# Table name: rooms
#
#  id              :bigint           not null, primary key
#  is_private      :boolean          default(FALSE)
#  last_message_at :datetime
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Room < ApplicationRecord
  validates_uniqueness_of :name, presence: true
  scope :public_rooms, -> { where(is_private: false) }

  after_update_commit { broadcast_if_public }
  
  has_many :messages, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :joinables, dependent: :destroy
  has_many :joined_accounts, through: :joinables, source: :account

  def broadcast_if_public
    broadcast_latest_message
    # broadcast_append_to "rooms" unless is_private
  end

  def self.create_private_room(accounts, room_name)
    single_room = Room.create(name: room_name, is_private: true)
    accounts.each do |account|
      Participant.create(account_id: account.id, room_id: single_room.id)
    end
    single_room
  end

  def participant?(room, account)
    room.participants.where(account: account).exists?
    # Participant.where(account_id: account.id, room_id: room.id).exists?
  end

  def latest_message
    messages.includes(:account).order(id: :desc).first
  end

  def broadcast_latest_message
    last_message = latest_message

    return unless last_message

    target = "room_#{id} last_message"

    broadcast_update_to('rooms',
                         target: target,
                         partial: 'rooms/last_message',
                         locals: {
                           room: self,
                           account: last_message.account,
                           last_message: last_message
                         })
  end
end
