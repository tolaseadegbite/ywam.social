# == Schema Information
#
# Table name: accounts
#
#  id                     :bigint           not null, primary key
#  account_type           :integer          default("individual"), not null
#  admin                  :boolean          default(FALSE)
#  bio                    :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  firstname              :string
#  mod                    :boolean          default(FALSE)
#  organization_name      :string
#  organization_type      :integer          default("base"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  surname                :string
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_accounts_on_email                 (email) UNIQUE
#  index_accounts_on_reset_password_token  (reset_password_token) UNIQUE
#  index_accounts_on_username              (username) UNIQUE
#
class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # make sure the follwing conditional account attributes for individual account type are present before saving to database
  validates :firstname, :surname, :username, :bio, presence: true, if: :individual?

  # make sure the follwing conditional account attributes for organization account type are present before saving to database
  validates :organization_name, :organization_type, :username, :bio, presence: true, if: :organization?

  # validates that the following attributes are present before saving to database
  validates :country, presence: true
  validates :state, presence: { if: ->(record) { record.states.present? } }
  validates :city, presence: { if: ->(record) { record.cities.present? } }

  # validates that states and cities must belong to proper parent
  validates :state, inclusion: { in: ->(record) { record.states.keys }, allow_blank: true }
  validates :city, inclusion: { in: ->(record) { record.cities }, allow_blank: true }

  # associates account to many events and delete events associated when a account is deleted from the database
  has_many :events, dependent: :destroy

  # associates account to the following objects
  has_many :event_categories
  has_many :event_speakers
  has_many :event_talks
  has_many :speaker_profiles

  has_many :addresses, dependent: :destroy

  # account type options
  enum account_type: {
    individual: 0,
    organization: 1
  }

  # organization type options
  enum organization_type: {
    base: 0,
    ministry: 1
  }

  def organization?
    account_type == 'organization'
  end

  def individual?
    account_type == 'individual'
  end

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
