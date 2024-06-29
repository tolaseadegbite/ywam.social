json.extract! prayer_request, :id, :title, :description, :account_id, :saves_count, :created_at, :updated_at
json.url prayer_request_url(prayer_request, format: :json)
