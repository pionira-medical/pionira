# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Order.delete_all
Image.delete_all

16.times do
  Order.create({
    :hospital => Faker::Company.name,
    :department => Faker::Commerce.department,
    :street_1 => Faker::Address.street_address,
    :street_2 => Faker::Address.street_suffix,
    :zip => Faker::Address.zip_code,
    :city => Faker::Address.city, 
    :country => "Deutschland",
    :gender => ["Herr","Frau"][rand(2)],
    :dr_title => ['Dr.', 'Dr. Prof.', 'Dr. Med.'].shuffle.first,
    :first_name => Faker::Name.first_name,
    :last_name => Faker::Name.last_name,
    :email => Faker::Internet.email,
    :phone => Faker::PhoneNumber.phone_number,
    :delivered_at => rand(1..10).days.from_now
  })
end