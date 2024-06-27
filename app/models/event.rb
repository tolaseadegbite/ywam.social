# == Schema Information
#
# Table name: events
#
#  id                :bigint           not null, primary key
#  city              :string
#  cost_type         :integer
#  country           :string
#  details           :text
#  end_date          :date
#  end_time          :time
#  event_type        :integer
#  name              :string
#  start_date        :date
#  start_time        :time
#  state             :string
#  status            :enum             default("draft"), not null
#  streaming_link    :string
#  street_address    :string
#  time_zone         :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  account_id        :bigint           not null
#  event_category_id :bigint           not null
#
# Indexes
#
#  index_events_on_account_id         (account_id)
#  index_events_on_event_category_id  (event_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (event_category_id => event_categories.id)
#
class Event < ApplicationRecord
    # make sure the follwing event attributes are present before saving to database
    validates :name, :start_date, :start_time, :time_zone, :details, :streaming_link, :event_type, :cost_type, presence: true

    # validates that states belong to proper country and cities belong to proper state
    validates :state, inclusion: { in: ->(record) { record.states.keys }, allow_blank: true }
    validates :city, inclusion: { in: ->(record) { record.cities }, allow_blank: true }

    # associate event to a account
    belongs_to :account

    # associate the follwing objects to an event and also delete from database when the event is destroyed
    has_many :event_speakers, dependent: :destroy
    has_many :event_talks, dependent: :destroy

    has_many :event_co_hosts, dependent: :destroy
    has_many :co_hosts, through: :event_co_hosts, source: :account

    def add_co_host(account)
        event_co_hosts.create(account: account, role: :co_host, status: :pending)
    end

    def remove_co_host(account)
        event_co_hosts.find_by(account: account)&.destroy
    end

    # event types
    enum event_type: {
        online: 0,
        'in-person': 1,
        'online and in-person': 2
    }

    # cost type options
    enum cost_type: {
        "free (only option for now)": 0
    }

    # postgres enums for status
    enum :status, {
        draft: 'draft',
        published: 'published'
    }, default: 'draft'

    scope :ordered, -> { published }

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
