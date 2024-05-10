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
    validates :name, presence: true
    validates_uniqueness_of :name, presence: true
    scope :public_rooms, -> { where(is_private: false) }

    after_create_commit { broadcast_append_to "rooms" }
    
    has_many :messages, dependent: :destroy
end
