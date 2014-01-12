require 'open-uri'

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

# If the seed image is coming from your the internet we can call that and turn it into a filepath.
# url ='http://upload.wikimedia.org/wikipedia/commons/9/9a/Honda_hs1136_snowblower.jpg'
# filepath = File.basename(URI.parse(url).path)

#for our seed data we will stor the images locally and then upload them to Amazon
filepath = "app/assets/images/shed_bg.jpg"
snowy2 = File.open(filepath)

users = [
        {
          name: "Suzy Lue",
          email: "sue@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "100 Colorado St",
          city: "Austin",
          zipcode: "78701",
          state: "TX",
          picture: snowy2
        },

        {
          name: "Ted Smith",
          email: "ted@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "1100 Congress Ave",
          city: "Austin ",
          zipcode: "78701",
          state: "TX",
          picture: snowy2
        },

        {
          name: "Jason Kool",
          email: "jason@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "120 E 7th St",
          city: "Austin",
          zipcode: "78701",
          state: "TX",
          picture: snowy2
        },

        {
          name: "Karen Holland",
          email: "karen@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "214 W 4th St",
          city: "Austin",
          zipcode: "78701",
          state: "TX",
          picture: snowy2
        }
]

users.each do |user|
  User.create!(name:user[:name], email:user[:email], password:user[:password], phone_num:user[:phone_num], street:user[:street], city:user[:city], zipcode:user[:zipcode], state:user[:state])
end

puts "destroy resource data"
Resource.destroy_all

puts "added dummy data for resource"
resources = [
       
          {
            name: "Tile Cutter",
            description: "Old but tough. Can cut any size tiles. New blades",
            user_id: 2,
            picture: snowy2
          },
          {
            name: "Router",
            description: "Milwaukee 3-1/2 Max HP Fixed-Base Production ",
            user_id: 2,
            picture: snowy2
          },
          {
            name: "Table Saw",
            description: "DEWALT 10 in. Jobsite Table Saw with Rolling Stand",
            user_id: 3,
            picture: snowy2
          },
          {
            name: "Router Table",
            description: "Kreg Precision Router Table System",
            user_id: 4,
            picture: snowy2
          },
          {
            name: "Jumper",
            description: "Tasco Pro 2200-Amp Jump Start Power Pack and Air Compressor",
            user_id: 1,
            picture: snowy2
          },
          {
            name: "Snow Blower",
            description: "Sno-Tek 24 in. Two-Stage Electric Start Gas Snow Blower",
            user_id: 2,
            picture: snowy2
          }
        
]


resources.each do |resource|
  Resource.create(picture:resource[:picture], name:resource[:name], description:resource[:description], user_id:resource[:user_id])
end

