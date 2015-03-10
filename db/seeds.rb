# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Studio.find_or_create_by!(id: 1, title: "Castle Rock")
Studio.find_or_create_by!(id: 2, title: "MiramaxFilms")
Studio.find_or_create_by!(id: 3, title: "RegencyEnterprises")
Studio.find_or_create_by!(id: 4, title: "Pixar")
Studio.find_or_create_by!(id: 5, title: "Disney")
