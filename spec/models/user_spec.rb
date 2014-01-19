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
          street: '808 Congress',
          city: '', 
          state: '', 
          zipcode: '')
      end
      
      it 'should have valid latitude and longitude' do
        expect(user.latitude).to eq 31.3657208
        expect(user.longitude).to eq -81.423445
      end
    end

    context 'when given am empty address' do
      let(:user) do 
        User.create(email: 'testing3@example.com',
          password: 'testing1234',
          street: '',
          city: '', 
          state: '', 
          zipcode: '')
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
        miles = user1.distances()
        expect(miles[user2.id]).to include("0.00")
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
        miles = user1.distances()
        #puts miles
        expect(miles[user2.id]).to include("0.61")
      end  
    end  
  end

  DatabaseCleaner.clean
  describe 'on pending request' do
    context 'when one pending request' do
      let!(:user1) do 
        User.create(email: 'testing1@example.com',
          password: 'testing1234')
      end
      let!(:user2) do 
        User.create(email: 'testing2@example.com',
          password: 'testing1234')
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
          password: 'testing1234')
      end
      let!(:user2) do 
        User.create(email: 'testing2@example.com',
          password: 'testing1234')
      end     
      let!(:user3) do 
        User.create(email: 'testing3@example.com',
          password: 'testing1234')
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

end