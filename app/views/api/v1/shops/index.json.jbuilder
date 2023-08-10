json.array! @shops do |shop|
  json.extract! shop, :id, :name, :street, :zipcode, :city, :neighbourhood, :popup
end
