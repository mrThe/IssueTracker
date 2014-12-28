# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

statuses = [
  { name: "Waiting for Staff Response", flag: :initial },
  { name: "Waiting for Customer",       flag: :waiting },
  { name: "On Hold",                    flag: :on_hold },
  { name: "Cancelled",                  flag: :cancelled },
  { name: "Completed",                  flag: :completed }
]

Status.create statuses
