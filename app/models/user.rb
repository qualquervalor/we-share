class User < ActiveRecord::Base
  validate :city_or_zipcode
  before_save :request_location
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :resources, :dependent => :destroy
  has_many :borrows, :dependent => :destroy
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

  def user_distance(user)
    if (self.latitude && self.longitude) 
      lat1 = self.latitude
      long1 = self.longitude
      if (user) 
        if (user.latitude && user.longitude) 
          lat2 = user.latitude
          long2 = user.longitude
          value = Haversine.distance(lat1,long1,lat2,long2).to_miles
          miles = sprintf('%.2f', value).to_f
        end
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
            user_distances[user] = user_distance(user)
          end
        end
      end
    end
    user_distances
  end

  def sort_users_and_distance(users)
    user_distances = distances(users)
    sorted =user_distances.sort_by { |user, miles| miles }
    sorted
  end

  def resource_distance(res)
    if (self.latitude && self.longitude) 
      lat1 = self.latitude
      long1 = self.longitude
      if (res.user)
        if (res.user.latitude && res.user.longitude) 
          lat2 = res.user.latitude
          long2 = res.user.longitude
          value = Haversine.distance(lat1,long1,lat2,long2).to_miles
          miles = sprintf('%.2f', value).to_f
        end
      end
    end  
  end

  def distances_by_resources(resources)
    resource_distances = {}
    if (self.latitude && self.longitude) 
      lat1 = self.latitude
      long1 = self.longitude
      resources.each do |res| 
        if (res.user)
          if (res.user.latitude && res.user.longitude) 
            resource_distances[res] = resource_distance(res)
          end
        end
      end
    end
    resource_distances
  end

  def sort_resources_and_distance(resources)
    resources_distances = distances_by_resources(resources)# {brick: 4, ball: 2}
    sorted =resources_distances.sort_by { |resource, miles| miles }# [ [ball,2], [brick, 4]]
    sorted
  end

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

private

  def city_or_zipcode
    if (self.city.blank? && self.zipcode.blank?)
      errors.add(:base, "At a minimum please provide either a city or zipcode, your location details are used to improve distance calculations.")
    end
  end

end