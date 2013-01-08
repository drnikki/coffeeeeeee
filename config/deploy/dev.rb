# deploy should be triggered with:
# cap dev deploy -S branch=master

server "172.26.144.34", :app, :web, :primary => true

# this is all for dev right now
set :user,         "nstevens"
set :password,     "yu7U=aJe"

# on dev, we can deploy with just update
set :deploy_via, :remote_cache