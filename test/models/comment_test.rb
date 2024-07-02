# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  body             :text
#  commentable_type :string           not null
#  deleted_at       :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  account_id       :bigint           not null
#  commentable_id   :bigint           not null
#
# Indexes
#
#  index_comments_on_account_id   (account_id)
#  index_comments_on_commentable  (commentable_type,commentable_id)
#  index_comments_on_deleted_at   (deleted_at)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
require "test_helper"

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
