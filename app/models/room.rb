# == Schema Information
#
# Table name: rooms
#
#  id         :bigint           not null, primary key
#  is_private :boolean          default(FALSE)
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Room < ApplicationRecord
  validates_uniqueness_of :name, presence: true
  scope :public_rooms, -> { where(is_private: false) }

  # after_create_commit { broadcast_if_public }
  
  has_many :messages, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :joinables, dependent: :destroy
  has_many :joined_users, through: :joinables, source: :account

  def broadcast_if_public
    broadcast_append_to "rooms" unless is_private
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
end
