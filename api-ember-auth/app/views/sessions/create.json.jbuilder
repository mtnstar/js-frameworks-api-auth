json.errors { json.array!(@messages[:error]) }
json.messages { json.array!(@messages[:info]) }
if @api_key
  json.extract! @api_key, :client_id, :access_token
end
