# == Schema Information
#
# Table name: resources
#
#  id                   :bigint           not null, primary key
#  description          :text             not null
#  title                :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  account_id           :bigint           not null
#  resource_category_id :bigint           not null
#  youtube_id           :string
#
# Indexes
#
#  index_resources_on_account_id            (account_id)
#  index_resources_on_resource_category_id  (resource_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (resource_category_id => resource_categories.id)
#
require "test_helper"

class ResourceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
