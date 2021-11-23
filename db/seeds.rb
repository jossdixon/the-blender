# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
require "open-uri"

User.destroy_all
Profile.destroy_all

puts "Seeding..."
User.create(first_name: 'Michiharu', last_name: 'Ono', email: 'michi@theblender.one', password: '123450987' )



csv_options = { col_sep: ',', quote_char: '"', headers: :first_row, header_converters: :symbol }
filepath    = File.join(__dir__,'users.csv')

CSV.foreach(filepath, csv_options) do |row|
email = row[:email]
encrypted_password = row[:encrypted_password]
first_name = row[:first_name]
last_name = row[:last_name]
user = User.new(email: email, password: encrypted_password, first_name: first_name, last_name: last_name)
user.save!
village = row[:village]
birthday = row[:birthday]
phone_number = row[:phone_number]
join_date = row[:join_date]
business_type = row[:business_type]
file = URI.open(row[:photo_url])
profile = Profile.new(
  village: village,
  birthday: birthday,
  phone_number: phone_number,
  join_date: join_date,
  business_type: business_type,
  user: user
)
profile.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
profile.save!
end
puts "Seeding done."
