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
require "test_helper"

class RoomTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
