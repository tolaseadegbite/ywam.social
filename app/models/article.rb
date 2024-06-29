class Article < ApplicationRecord
  belongs_to :account
  belongs_to :event_category
end
