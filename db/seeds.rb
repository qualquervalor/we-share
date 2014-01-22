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
 

suzy = File.open("public/assets/sue.jpb-0eeebdbe47f4aa1afbeb5ae238d2bd33.jpg") 
ted = File.open("public/assets/Ted-3edcbe7f2115421d0ae6ddffcb4eba92.gif")
karen = File.open("public/assets/Karen-088cea3a6f6b5e6e02fa181f74c13690.jpeg")
jason = File.open("public/assets/Jason-b25310ece9ea99494619084bc799ad3e.jpg")


user1 = User.create!({
          name: "Suzy Lue",
          email: "sue@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "100 Colorado St",
          city: "Austin",
          zipcode: "78701",
          state: "TX",
          latitude: 30.2639532,
          longitude: -97.74595359999999,
          picture: suzy
        })


user2 = User.create!({
          name: "Ted Smith",
          email: "ted@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "1100 Congress Ave",
          city: "Austin ",
          zipcode: "78701",
          state: "TX",
          latitude: 30.2747025,
          longitude: -97.7403448,
          picture: ted
        })

user3 = User.create!({
          name: "Jason Kool",
          email: "jason@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "120 E 7th St",
          city: "Austin",
          zipcode: "78701",
          state: "TX",
          latitude: 30.268785,
          longitude: -97.7413576,
          picture: jason
        })

user4 = User.create!({        
          name: "Karen Holland",
          email: "karen@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "214 W 4th St",
          city: "Austin",
          zipcode: "78701",
          state: "TX",
          latitude: 30.267047,
          longitude: -97.745435,
         picture: karen
        })



puts "destroy resource data"
Resource.destroy_all

puts "added dummy data for resource"

tilecutter = File.open("public/assets/Tile-cutter2.jpg")
ladder = File.open("public/assets/sixfootstepladder.jpg")
router = File.open("public/assets/Router1.jpg")
tablesaw = File.open("public/assets/tablesaw.jpg")
routertable = File.open("public/assets/Router2.jpg")
jumper = File.open("public/assets/jumper.jpg")
snowblower = File.open("public/assets/snowblower.jpg")




resources = [
       
          {
            name: "Tile Cutter",
            description: "Can cut any size tiles. New blades",
            user_id: user1,
            picture: tilecutter
          },
           {
            name: "Ladder",
            description: "13-foot ladder.  Bit dirty, but it does the job!",
            user_id: user1,
            picture: ladder
          },
          {
            name: "Older Black & Decker & Router",
            description: "Production ",
            user_id: user2,
            picture: router
          },
          {
            name: "Table Saw",
            description: "Craftsman Table Saw with Rolling Stand",
            user_id: user3,
            picture: tablesaw
          },
          {
            name: "Router",
            description: "My grandfathes router. Works everytime!",
            user_id: user4,
            picture: routertable
          },
          {
            name: "Jumper",
            description: "EverStart 300-Amp Jumper for Car",
            user_id: user1,
            picture: jumper
          },
          {
            name: "Snow Blower",
            description: "Craftsman 24 in. Two-Stage Electric Start Gas Snow Blower",
            user_id: user2,
            picture: snowblower
          }
        
]

resources.each do |resource|
  Resource.create(name:resource[:name], description:resource[:description], user:resource[:user_id],picture:resource[:picture])
end

puts "add reource dummy data"



