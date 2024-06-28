# == Schema Information
#
# Table name: rsvps
#
#  id            :bigint           not null, primary key
#  rsvpable_type :string           not null
#  status        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  account_id    :bigint           not null
#  rsvpable_id   :bigint           not null
#
# Indexes
#
#  index_rsvps_on_account_id  (account_id)
#  index_rsvps_on_rsvpable    (rsvpable_type,rsvpable_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
require "test_helper"

class RsvpTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
