# == Schema Information
#
# Table name: bookmarks
#
#  id                :bigint           not null, primary key
#  bookmarkable_type :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  account_id        :bigint           not null
#  bookmarkable_id   :bigint           not null
#
# Indexes
#
#  idx_on_account_id_bookmarkable_type_bookmarkable_id_5b0c838494  (account_id,bookmarkable_type,bookmarkable_id) UNIQUE
#  index_bookmarks_on_account_id                                   (account_id)
#  index_bookmarks_on_bookmarkable                                 (bookmarkable_type,bookmarkable_id)
#  index_bookmarks_on_bookmarkable_type_and_bookmarkable_id        (bookmarkable_type,bookmarkable_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
require "test_helper"

class BookmarkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
