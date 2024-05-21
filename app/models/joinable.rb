# == Schema Information
#
# Table name: joinables
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#  room_id    :bigint           not null
#
# Indexes
#
#  index_joinables_on_account_id  (account_id)
#  index_joinables_on_room_id     (room_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (room_id => rooms.id)
#
class Joinable < ApplicationRecord
  belongs_to :account
  belongs_to :room
end
