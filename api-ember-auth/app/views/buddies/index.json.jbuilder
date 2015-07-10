json.errors { json.array!(@messages[:error]) }
json.messages { json.array!(@messages[:info]) }
json.buddies do |json|
  json.array!(@buddies) do |buddy|
    json.extract! buddy, :id, :name
  end
end
