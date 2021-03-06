# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# store-wide variables
StoreConfig.create(name:  'status', value: "closed") # closed, open, break 
StoreConfig.create(name: 'milks', value: 'regular,soy,skim,half and half') # not sure about this one...

# state of now variables
StoreConfig.create(name: 'busy_until', value: '') # this is a timestamp.

# stats we can calculate once a whenever
StoreConfig.create(name: 'avg_wait_time', value: 4) # in minutes.

# menu items
MenuItem.create(name: 'capuccino', description: 'A normal, regular milk cappuccino')
MenuItem.create(name: 'coffee', description: 'A normal, regular milk coffee')
MenuItem.create(name: 'latte', description: 'A normal, regular milk latte')
MenuItem.create(name: 'macchiato', description: 'A normal, regular milk macchiato')
