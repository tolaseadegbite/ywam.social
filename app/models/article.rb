# == Schema Information
#
# Table name: articles
#
#  id          :bigint           not null, primary key
#  body        :text             not null
#  likes_count :integer          default(0), not null
#  saves_count :integer          default(0), not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :bigint           not null
#
# Indexes
#
#  index_articles_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Article < ApplicationRecord
  belongs_to :account

  has_many :comments, -> { order(created_at: :desc) }, as: :commentable, dependent: :destroy, inverse_of: :commentable
end
