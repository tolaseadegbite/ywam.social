# == Schema Information
#
# Table name: addresses
#
#  id         :bigint           not null, primary key
#  city       :string
#  country    :string
#  state      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#
# Indexes
#
#  index_addresses_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Address < ApplicationRecord
  # validates that the following attributes are present before saving to database
  validates :country, presence: true
  validates :state, presence: { if: ->(record) { record.states.present? } }
  validates :city, presence: { if: ->(record) { record.cities.present? } }

  # validates that states and cities must belong to proper parent
  validates :state, inclusion: { in: ->(record) { record.states.keys }, allow_blank: true }
  validates :city, inclusion: { in: ->(record) { record.cities }, allow_blank: true }

  belongs_to :account

  def countries
    CS.countries.with_indifferent_access
  end  

  def states
    CS.states(country).with_indifferent_access
  end

  def cities
    CS.cities(state, country) || []
  end

  def country_label
    countries[country]
  end

  def state_label
    states[state]
  end
end
