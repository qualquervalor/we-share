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
          picture: suzy
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
          picture: ted
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
          picture: jason
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
          picture: karen
        }
]

users.each do |user|
  User.create!(name:user[:name], email:user[:email], password:user[:password], phone_num:user[:phone_num], street:user[:street], city:user[:city], zipcode:user[:zipcode], state:user[:state], picture:user[:picture])
end

puts "destroy resource data"
Resource.destroy_all

puts "added dummy data for resource"

tilecutter = File.open("public/assets/tilecutter-0c61b39b213945eba1d1a41145004c69.jpg")
ladder = File.open("public/assets/ladder-710be23aa20198e47f4f9788f5176d33.jpg")
router = File.open("public/assets/router-ff5a8b1206d32dc7abfd24f0eb557930.jpg")
tablesaw = File.open("public/assets/tablesaw-37192e882d5449ec6da6468a61eac5b6.jpg")
routertable = File.open("public/assets/router2-0a295afbc21223617ad777f750162555.jpg")
jumper = File.open("public/assets/jumper-81ea66dd8fb51c55e49b20a628f5c7f7.jpg")
snowblower = File.open("public/assets/snowblower-97fb553dc1d771e8a261b483791af089.jpg")











resources = [
       
          {
            name: "Tile Cutter",
            description: "Old but tough. Can cut any size tiles. New blades",
            user_id: 2,
            picture: tilecutter
          },
           {
            name: "Ladder",
            description: "20-foot ladder.  Bit dirty, but it does the job!",
            user_id: 3,
            picture: ladder
          },
          {
            name: "Router",
            description: "Milwaukee 3-1/2 Max HP Fixed-Base Production ",
            user_id: 2,
            picture: router
          },
          {
            name: "Table Saw",
            description: "DEWALT 10 in. Jobsite Table Saw with Rolling Stand",
            user_id: 3,
            picture: tablesaw
          },
          {
            name: "Router Table",
            description: "Kreg Precision Router Table System",
            user_id: 4,
            picture: routertable
          },
          {
            name: "Jumper",
            description: "Tasco Pro 2200-Amp Jump Start Power Pack and Air Compressor",
            user_id: 1,
            picture: jumper
          },
          {
            name: "Snow Blower",
            description: "Sno-Tek 24 in. Two-Stage Electric Start Gas Snow Blower",
            user_id: 2,
            picture: snowblower
          }
        
]


resources.each do |resource|
  Resource.create(picture:resource[:picture], name:resource[:name], description:resource[:description], user_id:resource[:user_id])
end

