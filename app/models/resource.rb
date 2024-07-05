# == Schema Information
#
# Table name: resources
#
#  id                   :bigint           not null, primary key
#  description          :text             not null
#  title                :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  account_id           :bigint           not null
#  resource_category_id :bigint           not null
#  youtube_id           :string
#
# Indexes
#
#  index_resources_on_account_id            (account_id)
#  index_resources_on_resource_category_id  (resource_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (resource_category_id => resource_categories.id)
#
class Resource < ApplicationRecord
  validates :title, :description, :account_id, :resource_category_id, presence: true

  validates :youtube_id, presence: true, if: -> { resource_category&.name == 'video' }
  validates :audio, presence: true, if: -> { resource_category&.name == 'audio' }
  validates :file, presence: true, if: -> { resource_category&.name == 'pdf' }

  belongs_to :resource_category
  belongs_to :account

  # has_rich_text :description

  has_one_attached :cover_image

  has_one_attached :file

  has_one_attached :audio

  validates :file, content_type: { in: %w[application/pdf],
                                   message: "must be a PDF format" },
                   size: { less_than: 50.megabytes,
                           message: "should be less than 50MB" },
                   if: -> { resource_category&.name == 'pdf' }

  validates :cover_image, presence: true,   content_type: { in: %w[image/jpeg image/png],
                                    message: "must be a valid image format" },
                    size:         { less_than: 1.megabytes,
                                    message:   "should be less than 1MB" }
end
