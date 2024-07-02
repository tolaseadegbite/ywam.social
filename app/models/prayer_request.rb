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
class PrayerRequest < ApplicationRecord
  belongs_to :account

  has_many :comments, -> { order(created_at: :desc) }, as: :commentable, dependent: :destroy, inverse_of: :commentable
end
