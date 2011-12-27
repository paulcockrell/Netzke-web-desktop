# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# TODO: replace with faker
Role.create([
  {:name => "writer"},
  {:name => "reader"}
])

User.create([
  {:first_name => "Mark", :last_name => "Twain", :role => Role.find_by_name("writer")},
  {:first_name => "Carlos", :last_name => "Castaneda", :role => Role.find_by_name("writer")},
  {:first_name => "Sergei", :last_name => "Kozlov", :role => Role.find_by_name("reader")},
  {:first_name => "Paul", :last_name => "Schyska", :role => Role.find_by_name("reader")}
])

Author.create([
  {:first_name => "Paul", :last_name => "Cockrell"}
])

# Initial tree data
root = Infrastructure.create(:label => '/', :editable => false)
unknown = root.children.create(:label => 'Unknown', :editable => false)

# Operating systems data
OperatingSystem.create(:label => 'Linux', :version => '')
OperatingSystem.create(:label => 'Windows', :version => '')
OperatingSystem.create(:label => 'MacOS', :version => '')

# Device types data
NodeType.create(:label => 'Unknown')
NodeType.create(:label => 'Server')
NodeType.create(:label => 'Laptop')
NodeType.create(:label => 'Computer')
NodeType.create(:label => 'Switch')
NodeType.create(:label => 'PDU')
NodeType.create(:label => 'VDU')
