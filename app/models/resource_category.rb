# == Schema Information
#
# Table name: resource_categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ResourceCategory < ApplicationRecord
    has_many :resources, dependent: :destroy
end
