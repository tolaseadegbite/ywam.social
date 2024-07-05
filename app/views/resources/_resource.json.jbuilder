json.extract! resource, :id, :title, :description, :link, :resource_category_id, :created_at, :updated_at
json.url resource_url(resource, format: :json)
