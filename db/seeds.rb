require 'csv'
require "open-uri"

puts "Destroying loans, users, and profiles..."
Loan.destroy_all
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
puts "Creating loans..."
7.times do
  loan = Loan.new(
    weeks: rand(4..25),
    start_date: Date.today + rand(-30..30),
    user: User.first
  )
  loan.save!
  3.times do
    Loanee.create!(
      loan: loan,
      total: rand(1000..5000),
      user: User.includes(:loanees, :profile).where(loanees: { user_id: nil }).where.not(profiles: { user_id: nil }).sample,
      status: [0, 2, 3].sample
    )
  end
end
puts "Seeding done."
