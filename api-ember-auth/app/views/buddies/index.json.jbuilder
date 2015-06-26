json.buddies do |json|
  json.array!(@buddies) do |buddy|
    json.extract! buddy, :id, :name
  end
end
