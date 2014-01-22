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

  paginates_per 4


  def self.search(search)
    if search
      find(:all, :conditions => ['name ILIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

  def as_json(options={})
    {                 
      id: self.id,
      name: self.name,
      street: self.street,
      city: self.city,
      zipcode: self.zipcode,
      state: self.state,
      phone_num: self.phone_num,     
      picture: self.picture.url,
      email: self.email  
    }
  end

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

  def distances(users)
    user_distances = {}
    if (self.latitude && self.longitude) 
      lat1 = self.latitude
      long1 = self.longitude
      users.each do |user| 
        if (user) 
          if (user.latitude && user.longitude) 
            lat2 = user.latitude
            long2 = user.longitude
            value = Haversine.distance(lat1,long1,lat2,long2).to_miles
            miles = sprintf('%.2f', value)
            user_distances[user] = miles
          end
        end
      end
    end
    user_distances
  end

  def sort_users_and_distance(users)
    user_distances = distances(users)
    pair = []
    sorted =user_distances.sort_by { |user, miles| miles }
    pair << sorted
    pair << user_distances
  end

  def distances_by_resources(resources)
    resource_distances = {}
    if (self.latitude && self.longitude) 
      lat1 = self.latitude
      long1 = self.longitude
      resources.each do |res| 
        if (res.user)
          if (res.user.latitude && res.user.longitude) 
            lat2 = res.user.latitude
            long2 = res.user.longitude
            value = Haversine.distance(lat1,long1,lat2,long2).to_miles
            miles = sprintf('%.2f', value)
            resource_distances[res] = miles
          end
        end
      end
    end
    resource_distances
  end

  def sort_resources_and_distance(resources)
    resources_distances = distances_by_resources(resources)
    pair = []
    sorted =resources_distances.sort_by { |resource, miles| miles }
    pair << sorted
    pair << resources_distances
  end

#    <%= raw @lat_lngs.to_json %>

#   def show
#     @destinations = @user.destinations
#     @lat_lngs = @destinations.map {|d| d.lat_lng}
#   end

 def their_requests
  requests = []
  self.resources.each do |resource| 
    resource.borrows.each do |borrow|
      if borrow.status != Borrow.returned
        requests << borrow
      end
    end
  end
  requests
 end 
 
 def my_pending_requests
  requests = []
  self.borrows.each do |borrow| 
    if borrow.status == Borrow.pending 
      requests << borrow
    end
  end
  requests
 end

 def my_borrows
  requests = []
  self.borrowed_resources.each do |res| 
    res.borrows.each do |borrow| 
      if borrow.status == Borrow.borrowed 
        requests << res
      end
    end
  end
  requests
 end

end
