# == Schema Information
#
# Table name: prayer_requests
#
#  id          :bigint           not null, primary key
#  description :text
#  saves_count :integer          default(0), not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :bigint           not null
#
# Indexes
#
#  index_prayer_requests_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
require "test_helper"

class PrayerRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
