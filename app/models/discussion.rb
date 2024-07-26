# == Schema Information
#
# Table name: discussions
#
#  id          :bigint           not null, primary key
#  likes_count :integer          default(0), not null
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :bigint           not null
#  forum_id    :bigint           not null
#
# Indexes
#
#  index_discussions_on_account_id  (account_id)
#  index_discussions_on_forum_id    (forum_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (forum_id => forums.id)
#
class Discussion < ApplicationRecord
  belongs_to :forum
  belongs_to :account
  has_rich_text :body

  has_many :likes, as: :likeable

  has_many :comments, -> { order(created_at: :desc) }, as: :commentable, dependent: :destroy, inverse_of: :commentable
end
