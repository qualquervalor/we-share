# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "clearing data in users table"

User.destroy_all
puts "adding dummy data for users table"

users = [
        {
          name: "Suzy Lue",
          email: "sue@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "100 Colorado St",
          city: "Austin",
          zipcode: "78701",
          state: "TX"
        },

        {
          name: "Ted Smith",
          email: "ted@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "1100 Congress Ave",
          city: "Austin ",
          zipcode: "78701",
          state: "TX"
        },

        {
          name: "Jason Kool",
          email: "jason@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "120 E 7th St",
          city: "Austin",
          zipcode: "78701",
          state: "TX"
        },

        {
          name: "Karen Holland",
          email: "karen@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "214 W 4th St",
          city: "Austin",
          zipcode: "78701",
          state: "TX"
        }
]

users.each do |user|
  User.create!(name:user[:name], email:user[:email], password:user[:password], phone_num:user[:phone_num], street:user[:street], city:user[:city], zipcode:user[:zipcode], state:user[:state])
end

puts "added dummy data for users"
puts "destroy user data"

Resource.destroy_all
resources = [
       
          {
            name: "Tile Cutter",
            description: "Old but tough. Can cut any size tiles. New blades",
            user_id: 2,
          },
          {
            name: "Router",
            description: "Milwaukee 3-1/2 Max HP Fixed-Base Production ",
            user_id: 2
          },
          {
            name: "Table Saw",
            description: "DEWALT 10 in. Jobsite Table Saw with Rolling Stand",
            user_id: 3
          },
          {
            name: "Router Table",
            description: "Kreg Precision Router Table System",
            user_id: 4
          },
          {
            name: "Jumper",
            description: "Tasco Pro 2200-Amp Jump Start Power Pack and Air Compressor",
            user_id: 1
          },
          {
            name: "Snow Blower",
            description: "Sno-Tek 24 in. Two-Stage Electric Start Gas Snow Blower",
            user_id: 2 
          }
        
]

resources.each do |resource|
  Resource.create(name:resource[:name], description:resource[:description], user_id:resource[:user_id])
end

puts "add reource dummy data"



