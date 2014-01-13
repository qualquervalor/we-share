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
  def request_location()
    attrs = ["street", "city", "state", "zipcode"]
    if (self.changed & attrs).any?
      address = self.street+","+self.city+","+self.state+" "+self.zipcode
      obj = Geocoder.search(address)
      self.latitude = obj[0].latitude
      self.longitude = obj[0].longitude
    end
  end
end
