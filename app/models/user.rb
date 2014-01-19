class User < ActiveRecord::Base
  before_save :request_location
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :resources
  has_many :borrows
  has_many :borrowed_resources, source: :resource, through: :borrows

  mount_uploader :picture, ImageUploader

  #use geocoder to record lat and long
  def request_location
    attrs = ["street", "city", "state", "zipcode"]
    if (self.changed & attrs).any?
      address = self.street+","+self.city+","+self.state+" "+self.zipcode
      obj = Geocoder.search(address)
      if obj.length > 0
        self.latitude = obj[0].latitude
        self.longitude = obj[0].longitude
      end
    end
  end

  def distances()
    user_distances = {}
    lat1 = self.latitude
    long1 = self.longitude
    users = User.all
    users.each do |user| 
      lat2 = user.latitude
      long2 = user.longitude
      value = Haversine.distance(lat1,long1,lat2,long2).to_miles
      miles = sprintf('%.2f', value)
      user_distances[user.id] = miles
    end
    user_distances
  end
end


#    <%= raw @lat_lngs.to_json %>

#   def show
#     @destinations = @user.destinations
#     @lat_lngs = @destinations.map {|d| d.lat_lng}
#   end