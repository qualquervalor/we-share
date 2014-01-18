require 'spec_helper'

describe User do
    # t.string   "name"
    # t.string   "street"
    # t.string   "city"
    # t.string   "zipcode"
    # t.string   "state"
    # t.string   "phone_num"
    # t.text     "picture"
    # t.datetime "created_at"
    # t.datetime "updated_at"
    # t.integer  "resource_id"
    # t.integer  "borrow_id"
    # t.string   "email",                  default: "", null: false
    # t.string   "encrypted_password",     default: "", null: false
    # t.string   "reset_password_token"
    # t.datetime "reset_password_sent_at"
    # t.datetime "remember_created_at"
    # t.integer  "sign_in_count",          default: 0,  null: false
    # t.datetime "current_sign_in_at"
    # t.datetime "last_sign_in_at"
    # t.string   "current_sign_in_ip"
    # t.string   "last_sign_in_ip"
    # t.float    "latitude"
    # t.float    "longitude"
  describe 'on save' do
    context 'when given an address' do
      let(:user) do 
        User.create(email: 'testing@example.com',
          password: 'testing1234',
          street: '100 Colorado St', 
          city: 'Austin', 
          state: 'Tx', 
          zipcode: '78701')
      end
      
      it 'should have latitude and longitude' do
        expect(user.latitude).to eq 30.2639532
        expect(user.longitude).to eq -97.74595359999999
      end
    end
  end
      # allow(movie).to receive(:description).and_return("This sentence is exactly 51 characters long, I know")
      # expect(movie.snippet).to eq(
end

  # def request_location()
  #   attrs = ["street", "city", "state", "zipcode"]
  #   if (self.changed & attrs).any?
  #     address = self.street+","+self.city+","+self.state+" "+self.zipcode
  #     obj = Geocoder.search(address)
  #     self.latitude = obj[0].latitude
  #     self.longitude = obj[0].longitude
  #   end
  # end