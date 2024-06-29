# == Schema Information
#
# Table name: accounts
#
#  id                     :bigint           not null, primary key
#  account_type           :integer          default("individual"), not null
#  admin                  :boolean          default(FALSE)
#  bio                    :string
#  current_account        :integer
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  firstname              :string
#  mod                    :boolean          default(FALSE)
#  organization_name      :string
#  organization_type      :integer          default("base"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  status                 :integer          default("offline")
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

  scope :all_except, -> (account) { where.not(id: account) }
  after_create_commit { broadcast_append_to "accounts" }
  after_update_commit { broadcast_update }

  # associates account to many events and delete events associated when a account is deleted from the database
  has_many :events, dependent: :destroy

  # associates account to the following objects
  has_many :event_speakers
  has_many :event_talks
  has_many :speaker_profiles

  has_many :addresses, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :joinables, dependent: :destroy
  has_many :joined_rooms, through: :joinables, source: :room

  has_many :event_co_hosts, dependent: :destroy
  has_many :co_hosted_events, through: :event_co_hosts, source: :event

  has_many :rsvps, dependent: :destroy
  has_many :events, through: :rsvps, source: :rsvpable, source_type: 'Event'

  has_many :prayer_requests, dependent: :destroy

  # account avatar
  has_one_attached :avatar

  # add default avatar
  after_commit :add_default_avatar, on: %i[create update]

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

  def avatar_thumbnail
    avatar.variant(resize_to_limit: [150, 150]).processed
  end

  def chat_avatar
    avatar.variant(resize_to_limit: [50, 50]).processed
  end
  
  enum status: %i[offline away online]
  
  def broadcast_update
    broadcast_replace_to 'account_status', partial: 'accounts/status', account: self
  end

  def status_to_css
    case status
    when 'online'
      'bg-success'
    when 'away'
      'bg-warning'
    when 'offline'
      'bg-dark'
    else
      'bg-dark'
    end
  end

  private
  
    def add_default_avatar
      return if avatar.attached?

      avatar.attach(
        io: File.open(Rails.root.join('app', 'assets', 'images', 'default_profile.jpg')),
        filename: 'default_profile.jpg',
        content_type: 'image/jpg'
      )
    end
end
