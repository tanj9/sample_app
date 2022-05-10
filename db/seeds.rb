# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'START SEEDING'

puts '1/2 - Seeding users 👩‍🦰👩‍🦱 (be patient... it takes time...)'
# Create a first user.
User.create!(name: 'Jérôme',
             email: 'jerome.Tan@tuta.io',
             password: '000000',
             password_confirmation: '000000',
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

# Create a main sample user.
User.create!(name: 'Example User',
             email: 'example@railstutorial.org',
             password: 'foobar',
             password_confirmation: 'foobar',
             activated: true,
             activated_at: Time.zone.now)

# Generate a bunch of additional users.
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

puts "1/2 - Created #{User.count} users. Thanks for your patience. 🙏"

puts '2/2 - Seeding microposts 🗒🗒'

# Generate microposts for a subset of 6 users.
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end

puts "2/2 - Created #{Microposts.count} microposts"

puts 'FINISHED SEEDING'
