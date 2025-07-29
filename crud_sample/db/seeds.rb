# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Creating 5 dummy employees..."

employees = []
5.times do |i|
  employee = Employee.create!(
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    phone: Faker::PhoneNumber.phone_number,
    has_passport: [ true, false ].sample,
    salary: Faker::Number.between(from: 30000, to: 100000),
    notes: Faker::Lorem.sentence(word_count: 5),
    birth_date: Faker::Date.birthday(min_age: 18, max_age: 65),
    hire_date: Faker::Date.backward(days: 365 * 10),
    gender: [ "Male", "Female", "Other" ].sample
  )
  employees << employee
end

puts "Dummy employees created!"

puts "Creating posts for employees..."

employees.each do |employee|
  # 각 직원마다 1~5개의 랜덤한 포스트 생성
  rand(1..5).times do
    employee.posts.create!(
      title: Faker::Lorem.sentence(word_count: rand(3..8)),
      content: Faker::Lorem.paragraphs(number: rand(1..4)).join("\n\n")
    )
  end
end

puts "Posts created for all employees!"
puts "Total employees: #{Employee.count}"
puts "Total posts: #{Post.count}"
