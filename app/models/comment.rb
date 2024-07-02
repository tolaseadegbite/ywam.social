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
class Comment < ApplicationRecord
  belongs_to :account
  belongs_to :commentable, polymorphic: true, inverse_of: :comments
  has_many :comments, as: :commentable, dependent: :destroy

  MIN_BODY_LENGTH = 2
  MAX_BODY_LENGTH = 1000

  validates :body, presence: true
  validates :body, length: { minimum: MIN_BODY_LENGTH, maximum: MAX_BODY_LENGTH }

  # soft delete
  def destroy
    update(deleted_at: Time.zone.now)
  end

  def find_top_parent
    return commentable unless commentable.is_a?(Comment)

    commentable.find_top_parent
  end
end
