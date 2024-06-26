# == Schema Information
#
# Table name: responses
#
#  id                :bigint           not null, primary key
#  responseable_type :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  account_id        :bigint           not null
#  responseable_id   :bigint           not null
#
# Indexes
#
#  idx_on_account_id_responseable_id_responseable_type_1fbc72c417  (account_id,responseable_id,responseable_type) UNIQUE
#  index_responses_on_account_id                                   (account_id)
#  index_responses_on_account_id_and_responseable_id               (account_id,responseable_id) UNIQUE
#  index_responses_on_responseable                                 (responseable_type,responseable_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Response < ApplicationRecord
  belongs_to :account
  belongs_to :responseable, polymorphic: true, counter_cache: :responses_count

  validates :account_id, uniqueness: { scope: [:responseable_id, :responseable_type] }
end
