# == Schema Information
#
# Table name: event_co_hosts
#
#  id         :bigint           not null, primary key
#  role       :integer          default("host")
#  status     :integer          default("pending")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#  event_id   :bigint           not null
#
# Indexes
#
#  index_event_co_hosts_on_account_id               (account_id)
#  index_event_co_hosts_on_event_id                 (event_id)
#  index_event_co_hosts_on_event_id_and_account_id  (event_id,account_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (event_id => events.id)
#
class EventCoHost < ApplicationRecord
  validates :event_id, uniqueness: { scope: :account_id, message: "Account is already a co-host for this event" }
  
  belongs_to :event
  belongs_to :account

  enum role: { nil: 0, host: 1, co_host: 2 }
  enum status: { pending: 0, accepted: 1, declined: 2 }
end
