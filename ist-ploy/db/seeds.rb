# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Skill.create(:name => "Programming", :description => "Programming")
Skill.create(:name => "Networking", :description => "Networking")
Skill.create(:name => "System Analysis", :description => "System Analysis")
Skill.create(:name => "Digital Art", :description => "Digital Art")
Skill.create(:name => "Protography", :description => "Protography")
Skill.create(:name => "Film And Animation", :description => "Film And Animation")

PortfolioCategory.create(:name => "Drawing")
PortfolioCategory.create(:name => "Painting")
PortfolioCategory.create(:name => "Photography")
PortfolioCategory.create(:name => "Film")

Tag.create(:name => "ThisIsATestTag")
Tag.create(:name => "JustAnotherTest")
Tag.create(:name => "PushTestAgain")

UserType.create(:name => "Admin")
UserType.create(:name => "Teacher")
UserType.create(:name => "Staff")
UserType.create(:name => "Student")