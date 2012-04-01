# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(login: 'root', full_name: 'Администратор', birthday: '2000-01-01',
  address: 'Независимости', city: 'Минск', state: 'Минск', country: 'Беларусь', zip: '220000',
  email: 'roo@root.com', password: 'root123456', role: 'admin')