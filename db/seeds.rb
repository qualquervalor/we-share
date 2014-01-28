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
 
shannon = File.open("public/assets/shannon.jpg")
harsh = File.open("public/assets/harsh.jpg")
shaan = File.open("public/assets/shaan.jpg")
mike = File.open("public/assets/mike.jpg")
gilbert = File.open("public/assets/gilbert.jpg")
shehzan = File.open("public/assets/shehzan.jpg")
ravi = File.open("public/assets/ravi.jpg")
amanda = File.open("public/assets/amanda.jpg")
osei = File.open("public/assets/osei.jpg")
gamble = File.open("public/assets/gamble.jpg")
clay = File.open("public/assets/clay.jpg")
alex = File.open("public/assets/alex.jpg")
elaine = File.open("public/assets/elaine.jpg")
jessica = File.open("public/assets/jessica.jpg")
taylor = File.open("public/assets/taylor.jpg")
jennifer = File.open("public/assets/jennifer.jpg")
casey = File.open("public/assets/casey.jpg")
chris = File.open("public/assets/chris.jpg")


user1 = User.create!({        
          name: "Shannon Bryne",
          email: "shannontest1234567890@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "2300 Windsor Rd",
          city: "Austin",
          zipcode: "78703",
          state: "TX",
          picture: shannon
        })

user2 = User.create!({        
          name: "Harsh Patel",
          email: "harshtest1234567890@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "2515 Pearl St",
          city: "Austin",
          zipcode: "78701",
          state: "TX",
          picture: harsh
        })

user3 = User.create!({        
          name: "Shaan Shah",
          email: "shaantest1234567890@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: " 801 Trinity St",
          city: "Austin",
          zipcode: "78701",
          state: "TX",
          picture: shaan
        })

user4 = User.create!({        
          name: "Mike Ornellas",
          email: "miketest1234567890@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "2607 W 7th St",
          city: "Austin",
          zipcode: "78703",
          state: "TX",
          picture: mike
        })

user5 = User.create!({        
          name: "Gilbert .JS",
          email: "gilberttest1234567890@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "3006 Gilbert St",
          city: "Austin",
          zipcode: "78703",
          state: "TX",
          picture: gilbert
        })

user16 = User.create!({        
          name: "Shehzan Devani",
          email: "shehzantest1234567890@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "1619 Forest Trail",
          city: "Austin",
          zipcode: "78703",
          state: "TX",
          picture: shehzan
        })

user7 = User.create!({        
          name: "Ravi Parikh",
          email: "ravitest1234567890@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "1405 Wathen Ave",
          city: "Austin",
          zipcode: "78703",
          state: "TX",
          picture: ravi
        })

user8 = User.create!({        
          name: "Amanda Contreras ",
          email: "amandatest1234567890@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "1111 W 5th St",
          city: "Austin",
          zipcode: "78703",
          state: "TX",
          picture: amanda
        })

user9 = User.create!({        
          name: "Osei Bonsu",
          email: "oseitest1234567890@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "2907 West Ave,",
          city: "Austin",
          zipcode: "78705",
          state: "TX",
          picture: osei 
        })

user10 = User.create!({        
          name: "Gamble McAdam",
          email: "gambletest1234567890@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "400 W 12 St",
          city: "Austin",
          zipcode: "78701",
          state: "TX",
          picture: gamble
        })

user11 = User.create!({        
          name: "Clay Stewart",
          email: "claytest1234567890@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "1601 Linscomb Ave",
          city: "Austin",
          zipcode: "78704",
          state: "TX",
          picture: clay
        })

user12 = User.create!({        
          name: "Alex Lavine",
          email: "alextest1234567890@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "200 E 17th St",
          city: "Austin",
          zipcode: "78701",
          state: "TX",
          picture: alex
        })

user13 = User.create!({        
          name: "Elaine Looney",
          email: "elainetest1234567890@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "805 W 10th St",
          city: "Austin",
          zipcode: "78701",
          state: "TX",
          picture: elaine
        })

user14 = User.create!({        
          name: "Jessica Ashley",
          email: "jessicatest1234567890@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "701 Baylor St",
          city: "Austin",
          zipcode: "78703",
          state: "TX",
          picture: jessica
        })

user15 = User.create!({        
          name: "Jennifer Scales",
          email: "jennifertest1234567890@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "208 W 8th St",
          city: "Austin",
          zipcode: "78701",
          state: "TX",
          picture: jennifer
        })

user16 = User.create!({        
          name: "Taylor Smith",
          email: "taylortest1234567890@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "601 W 18th",
          city: "Austin",
          zipcode: "78703",
          state: "TX",
          picture: taylor
        })

user17 = User.create!({        
          name: "Casey Lang",
          email: "caseytest1234567890@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "1505 Treadwell St",
          city: "Austin",
          zipcode: "78704",
          state: "TX",
          picture: casey
        })

user18 = User.create!({        
          name: "Chris Henney",
          email: "christest1234567890@gmail.com",
          password: "test1234",
          phone_num: "1234567890",
          street: "600 W 13th St",
          city: "Austin",
          zipcode: "78701",
          state: "TX",
          picture: chris
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

beltsander = File.open("public/assets/Belt_sander_bosch.jpg")
chopsaw = File.open("public/assets/chopsaw.jpg")
powerwasher = File.open("public/assets/Cleanforce1400psiElectricPressureWasher.jpg")
nailgun = File.open("public/assets/DeWalt-16-Nail-Gun.jpg")
circularsaw = File.open("public/assets/Dewalt-Circular-Saw-7.jpg")
feedweld = File.open("public/assets/feedweld.jpg")
steamcleaner = File.open("public/assets/KarcherSteamCleaner2.jpg")
ladderlevel = File.open("public/assets/ladderlevel.jpg")
paintsprayer = File.open("public/assets/large_paintsprayer.jpg") 
leafblower = File.open("public/assets/leafblower.jpg")
powersaw = File.open("public/assets/Makitapowersaw.jpg")
saw = File.open("public/assets/metabosaw.jpg")
footladder = File.open("public/assets/multitask17footladder.jpg")
nailgun2 = File.open("public/assets/Nail_gun_008.jpg")
shopvac = File.open("public/assets/our_shop_vacum.jpg")
paintsprayer = File.open("public/assets/paint_sprayer.jpg")
paintsprayer2 = File.open("public/assets/paint_sprayer2.jpg")
polesawhead = File.open("public/assets/PoleSawHead.jpg")
pressurewasher = File.open("public/assets/Pressure_Washer.jpg")
pushlawnmower = File.open("public/assets/pushlawnmower.jpg")
ridinglawnmower = File.open("public/assets/ridinglawnmower.jpg")
shopvac2 = File.open("public/assets/shopvac.jpg")
shopvac3 = File.open("public/assets/shopvacquietplus.jpg")
chainsaw = File.open("public/assets/stihlchainsaw.jpg")
ladder32 = File.open("public/assets/Werner32footextensionladder.jpg")
wheelbarrow = File.open("public/assets/wheelbarrow.jpg")
wheelbarrow2 = File.open("public/assets/wheelbarrow2.jpg")
woodchipper = File.open("public/assets/wood-chipper.jpg")


resources = [
       
          {
            name: "Tile Cutter",
            description: "Can cut any size tiles. New blades",
            user_id: user2,
            picture: tilecutter
          },
           {
            name: "Ladder",
            description: "13-foot ladder.  Bit dirty, but it does the job!",
            user_id: user13,
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
            user_id: user2,
            picture: tablesaw
          },
          {
            name: "Router",
            description: "My grandfathes router. Works everytime!",
            user_id: user10,
            picture: routertable
          },
          {
            name: "Jumper",
            description: "EverStart 300-Amp Jumper for Car",
            user_id: user18,
            picture: jumper
          },
          {
            name: "Snow Blower",
            description: "Craftsman 24 in. Two-Stage Electric Start Gas Snow Blower",
            user_id: user10,
            picture: snowblower
          },
          {
            name: "Bosch Belt Sander",
            description: "Craftsman 24 in. Two-Stage Electric Start Gas Snow Blower",
            user_id: user13,
            picture: beltsander
          },
          {
            name: "RYOBI Chop/Miter Saw",
            description: "Compound Miter Saw with some kick",
            user_id: user12,
            picture: chopsaw
          },
          {
            name: "Power Washer",
            description: "I use this to clean of the house after winter.",
            user_id: user11,
            picture: powerwasher
          },
          {
            name: "Nail Gun",
            description: "Dewalt 18v nail gun.  Not for kids please.",
            user_id: user10,
            picture: nailgun
          },
          {
            name: "Circular saw",
            description: "DeWalt. Works great. Brand new",
            user_id: user2,
            picture: circularsaw
          },
          {
            name: "Feed Weld",
            description: "I can show you how to weld almost anything with this tool",
            user_id: user8,
            picture: feedweld
          },
          {
            name: "Steam Cleaner",
            description: "Karcher Steam Cleaner for just about any dirty tile job!",
            user_id: user15,
            picture: steamcleaner 
          },
          {
            name: "Ladder Level",
            description: "If you need to paint your stairwell, this step works great.",
            user_id: user2,
            picture: ladderlevel
          },
          {
            name: "Paint Sprayer",
            description: "I use this for big paint jobs. Great for outdoor jobs",
            user_id: user5,
            picture: paintsprayer2
          },
          {
            name: "Leaf Blower",
            description: "Thar she blows! Very easy to start, no instructions needed.",
            user_id: user2,
            picture: leafblower
          },
          {
            name: "Power Saw",
            description: "Small but pretty cool Makita saw for wood projects",
            user_id: user18,
            picture: powersaw
          },
          {
            name: "Saw",
            description: "Metabo circular saw. Eyewear needed.",
            user_id: user2,
            picture: saw
          },
          {
            name: "Funky Foot Ladder",
            description: "Can use in ackward places that other ladders don't fit into.",
            user_id: user15,
            picture: footladder
          },
          {
            name: "Nail Gun",
            description: "A bit old, but still does a good job. Please buy your own nails.",
            user_id: user2,
            picture: nailgun2
          },
          {
            name: "Garage Shop Vac",
            description: "For dry jobs only, please do not use for water clean up.",
            user_id: user18,
            picture: shopvac
          },
          {
            name: "Paint Sprayer",
            description: "Wagner paint sprayer.  Latex paints only!",
            user_id: user13,
            picture: paintsprayer
          },
          {
            name: "Paint Sprayer",
            description: "Love my paint sprayer.  Works and no paint spills.",
            user_id: user16,
            picture: paintsprayer2
          },
          {
            name: "Tree Pole Saw",
            description: "Use for trimming those hard to reach branches",
            user_id: user15,
            picture: polesawhead
          },
          {
            name: "Pressure Washer",
            description: "Not for paint clean up as it can chip it off.  Use for pool patio and driveway power washing.",
            user_id: user10,
            picture: pressurewasher
          },
          {
            name: "Fun Push Lawnmower",
            description: "Not for someone who doesn't want to work a bit!",
            user_id: user13,
            picture: pushlawnmower
          },
          {
            name: "YARDMAN Riding Lawnmower",
            description: "I rarely use this.  Can borrow anytime. Please replace the gas.",
            user_id: user12,
            picture: ridinglawnmower
          },
          {
            name: "Car Shop Vac",
            description: "Great for car. Can use for just about anything. Return clean please.",
            user_id: user11,
            picture: shopvac2
          },
          {
            name: "Older Shop Vac",
            description: "Works. Need an extension cord as the one it has is pretty short.",
            user_id: user10,
            picture: shopvac3
          },
          {
            name: "Gas Chainsaw",
            description: "STIHL chainsaw for big jobs.",
            user_id: user9,
            picture: chainsaw
          },
          {
            name: "Tall Ladder",
            description: "Werner 32 foot extension ladder. Great for reaching the roof",
            user_id: user18,
            picture: ladder32
          },
          {
            name: "New Four wheel Wheelbarrow ",
            description: "So easy to use. Try it!",
            user_id: user7,
            picture: wheelbarrow2
          },
          {
            name: "Dirty Wheelbarrow",
            description: "Nothing special. Just a plain simple wheelbarrow.",
            user_id: user2,
            picture: wheelbarrow
          },
          {
            name: "Wood Chipper",
            description: "Craftsman wood chipper. Use it for landscaping jobs and never fails.",
            user_id: user10,
            picture: woodchipper
          }
        
]

resources.each do |resource|
  Resource.create(name:resource[:name], description:resource[:description], user:resource[:user_id],picture:resource[:picture])
end

puts "destroy borrows data"
Borrow.destroy_all

puts "added dummy data for borrow"


Borrow.create(user_id: 10, resource_id: 8 , status: "Borrowed")
Borrow.create(user_id: 10, resource_id: 14 , status: "Borrowed")
Borrow.create(user_id: 10, resource_id: 6 , status: "Borrowed")
Borrow.create(user_id: 10, resource_id: 29 , status: "Borrowed")
Borrow.create(user_id: 10, resource_id: 12 , status: "Borrowed")
Borrow.create(user_id: 10, resource_id: 9 , status: "Borrowed")
Borrow.create(user_id: 10, resource_id: 16, status: "Denied")
Borrow.create(user_id: 10, resource_id: 17, status: "Denied")

Borrow.create(user_id: 1, resource_id: 11, status: "Pending")
Borrow.create(user_id: 2, resource_id: 5, status: "Pending")












