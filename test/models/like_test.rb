# == Schema Information
#
# Table name: likes
#
#  id            :bigint           not null, primary key
#  likeable_type :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  account_id    :bigint           not null
#  likeable_id   :bigint           not null
#
# Indexes
#
#  index_likes_on_account_id                                    (account_id)
#  index_likes_on_account_id_and_likeable_id_and_likeable_type  (account_id,likeable_id,likeable_type) UNIQUE
#  index_likes_on_likeable                                      (likeable_type,likeable_id)
#  index_likes_on_likeable_id_and_likeable_type                 (likeable_id,likeable_type)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
require "test_helper"

class LikeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
