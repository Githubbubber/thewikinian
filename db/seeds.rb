# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# PEACH STUDENT: INSERT YOUR SEED CODE HERE

Post.destroy_all

3.times do
  #Title field
  FHS   = Faker::Hipster.sentence.gsub(/[.]/, "").titleize
  FHA   = Faker::Hacker.adjective.gsub(/[.]/, "").split.map(&:capitalize)*' '
  SWQ   = "A Star Wars Quote"
  # Author field
  FNFN  = Faker::Name.first_name.capitalize + ", hipster clone"
  FNFN2 = Faker::Name.first_name.capitalize + ", hacker whiz"
  FSWC  = Faker::StarWars.character
  #Content field
  FHP   = Faker::Hipster.paragraphs.join(" ")
  FHSSS = "\"" + Faker::Hacker.say_something_smart.capitalize + "\""
  FSWQ  = Faker::StarWars.quote.capitalize

  Post.create(title: FHS,   author: FNFN,   content: FHP)
  Post.create(title: FHA,   author: FNFN2,  content: FHSSS)
  Post.create(title: SWQ,   author: FSWC,   content: FSWQ)
end
