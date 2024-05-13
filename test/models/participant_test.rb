# == Schema Information
#
# Table name: participants
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#  room_id    :bigint           not null
#
# Indexes
#
#  index_participants_on_account_id  (account_id)
#  index_participants_on_room_id     (room_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (room_id => rooms.id)
#
require "test_helper"

class ParticipantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
