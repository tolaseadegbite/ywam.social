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
  before_save :clear_irrelevant_fields

  validates :title, :description, :account_id, :resource_category_id, presence: true

  validates :youtube_id, presence: true, if: -> { video_category? }
  validates :audio, presence: true, if: -> { audio_category? }
  validates :file, presence: true, if: -> { pdf_category? }

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
  private
  
        def clear_irrelevant_fields
                if resource_category_id_changed?
                        self.youtube_id = nil unless video_category?
                        self.audio = nil unless audio_category?
                        self.file = nil unless pdf_category?
                        # Add any other category-specific fields here
                end
        end

        def video_category?
                resource_category&.name&.downcase == 'video'
        end

        def audio_category?
                resource_category&.name&.downcase == 'audio'
        end

        def pdf_category?
                resource_category&.name&.downcase == 'pdf'
        end
end
