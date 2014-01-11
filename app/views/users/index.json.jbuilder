json.array!(@users) do |user|
  json.extract! user, :id, :name, :street, :city, :zipcode, :state, :phone_num, :picture
  json.url user_url(user, format: :json)
end
