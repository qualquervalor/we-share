require 'spec_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

describe User do

  DatabaseCleaner.clean
  describe 'on save' do
    context 'when given a full address' do
      let(:user) do 
        User.create(email: 'testing@example.com',
          password: 'testing1234',
          street: '100 Colorado St', 
          city: 'Austin', 
          state: 'Tx', 
          zipcode: '78701')
      end
      
      it 'should have valid latitude and longitude' do
        expect(user.latitude).to eq 30.2639532
        expect(user.longitude).to eq -97.74595359999999
      end
    end

    context 'when given a partial address' do
      let(:user) do 
        User.create(email: 'testing2@example.com',
          password: 'testing1234',
          street: '',
          city: 'Austin', 
          state: '', 
          zipcode: '')
      end
      
      it 'should have valid latitude and longitude' do
        expect(user.latitude).to eq 30.267153
        expect(user.longitude).to eq -97.7430608
      end
    end

    context 'when given am empty address' do
      let(:user) do 
        User.create(email: 'testing3@example.com',
          password: 'testing1234')
      end
      
      it 'should have invalid latitude and longitude' do
        expect(user.latitude).to be_nil
        expect(user.longitude).to be_nil
      end
    end

    context 'when given identical addresses' do
      let(:user1) do 
        User.create(email: 'testing4@example.com',
          password: 'testing1234',
          street: '100 Colorado St', 
          city: 'Austin', 
          state: 'Tx', 
          zipcode: '78701')
      end
      let(:user2) do 
        User.create(email: 'testing5@example.com',
          password: 'testing1234',
          street: '100 Colorado St', 
          city: 'Austin', 
          state: 'Tx', 
          zipcode: '78701')
      end

      it 'should have identical latitude and longitude' do
        expect(user1.latitude).to eq user2.latitude
        expect(user1.longitude).to eq user2.longitude
      end  
    end
   end

  DatabaseCleaner.clean
  describe 'on distance calculation' do
    context 'when given the same valid address' do
      let!(:user1) do 
        User.create(email: 'testing4@example.com',
          password: 'testing1234',
          street: '100 Colorado St', 
          city: 'Austin', 
          state: 'Tx', 
          zipcode: '78701')
      end     
      let!(:user2) do 
        User.create(email: 'testing5@example.com',
          password: 'testing1234',
          street: '100 Colorado St', 
          city: 'Austin', 
          state: 'Tx', 
          zipcode: '78701')
      end
      let!(:user3) do 
        User.create(email: 'testing6@example.com',
          password: 'testing1234',
          street: '100 Colorado St', 
          city: 'Austin', 
          state: 'Tx', 
          zipcode: '78701')
      end
      it 'returns 0.00 miles' do
        miles = user1.distances(User.all)
        expect(miles[user2]).to eq(0.00)
      end  
    end  

    DatabaseCleaner.clean
    context 'when given two address 0.61 miles apart' do
      let!(:user1) do 
        User.create(email: 'testing4@example.com',
          password: 'testing1234',
          street: '1000 Congress Ave', 
          city: 'Austin', 
          state: 'Tx', 
          zipcode: '78701')
      end     
      let!(:user2) do 
        User.create(email: 'testing5@example.com',
          password: 'testing1234',
          street: '100 Congress Ave', 
          city: 'Austin', 
          state: 'Tx', 
          zipcode: '78701')
      end
      it 'returns 0.61 miles' do
        miles = user1.distances(User.all)
        #puts miles
        expect(miles[user2]).to eq(0.61)
      end  
    end  
  end

  DatabaseCleaner.clean
  describe 'on pending request' do
    context 'when one pending request' do
      let!(:user1) do 
        User.create(email: 'testing1@example.com',
          password: 'testing1234',
          street: '',
          city: 'Austin', 
          state: '', 
          zipcode: '')
      end
      let!(:user2) do 
        User.create(email: 'testing2@example.com',
          password: 'testing1234',
          street: '',
          city: 'Austin', 
          state: '', 
          zipcode: '')
      end     
      let!(:resource2) do 
        Resource.create(name: 'ladder',user: user2)
      end     
      let!(:borrow1) do 
        Borrow.create(user: user1, resource: resource2, status: Borrow.pending)
      end
      let!(:borrow2) do 
        Borrow.create(user: user1, resource: resource2, status: Borrow.returned)
      end

      it 'should have one pending request' do
        expect(user1.my_pending_requests.length).to eq 1
      end
    end
  end

  DatabaseCleaner.clean
  describe 'on received request' do
    context 'when two oustanding request' do
      let!(:user1) do 
        User.create(email: 'testing1@example.com',
          password: 'testing1234',
          street: '',
          city: 'Austin', 
          state: '', 
          zipcode: '')
      end
      let!(:user2) do 
        User.create(email: 'testing2@example.com',
          password: 'testing1234',
          street: '',
          city: 'Austin', 
          state: '', 
          zipcode: '')
      end     
      let!(:user3) do 
        User.create(email: 'testing3@example.com',
          password: 'testing1234',
          street: '',
          city: 'Austin', 
          state: '', 
          zipcode: '')
      end 
      let!(:resource2) do 
        Resource.create(name: 'ladder',user: user2)
      end     
      let!(:borrow1) do 
        Borrow.create(user: user1, resource: resource2, status: Borrow.borrowed)
      end
      let!(:borrow2) do 
        Borrow.create(user: user1, resource: resource2, status: Borrow.returned)
      end
      let!(:borrow3) do 
        Borrow.create(user: user3, resource: resource2, status: Borrow.pending)
      end
      it 'should have two outstanding request' do
        expect(user2.their_requests.length).to eq 2
      end
    end
   end

   describe "sorting users" do
      let!(:user1) do 
        User.create(email: 'testing1@example.com',
          password: 'testing1234',
          street: '',
          city: 'Austin', 
          state: '', 
          zipcode: '')
      end
      let!(:user2) do 
        User.create(email: 'testing2@example.com',
          password: 'testing1234',
          street: '',
          city: 'San Antonio', 
          state: '', 
          zipcode: '')
      end     
      let!(:user4) do 
        User.create(email: 'testing4@example.com',
          password: 'testing1234',
          street: '',
          city: 'Houston', 
          state: '', 
          zipcode: '')
      end  
      let!(:user3) do 
        User.create(email: 'testing3@example.com',
          password: 'testing1234',
          street: '',
          city: 'New York', 
          state: '', 
          zipcode: '')
      end 

     it "should sort the users by distance" do
        sorted = user1.sort_users_and_distance([user2,user3,user4])
        cities = [sorted[0][0].city,sorted[1][0].city,sorted[2][0].city]
        #puts sorted[0][1].to_s+", "+sorted[1][1].to_s+", "+sorted[2][1].to_s
        expect(cities).to eq ['San Antonio','Houston','New York']
     end 
   end
end