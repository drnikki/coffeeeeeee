# multi-stage
set :stages, %w(dev qa prod)
set :default_stage, "dev" # stay safe!
require 'capistrano/ext/multistage'

# bundler, bitches, bundler
require "bundler/capistrano"

# global application variables
set :application, "coffee"
set :repository,  "git@github.com:drnikki/coffeeeeeee.git"
set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
set :deploy_to, "/var/www/coffee/"

# /var/www/coffee/builds/current is where the apache config is pointing

# global config variables 
default_run_options[:pty] = true	#for the 'no ttyp present and no askpass program error'
logger.level = Logger::MAX_LEVEL

set  :keep_releases,  1
set :git_shallow_clone, 1

# uh, this makes more sense
# these could change per environment.
# set :shared_dir,       "/var/www"
# set :tomcat_dest,      "/var/lib/tomcat7/webapps"
# set :webroot,          "/var/www/html"

# so that we can use a tag instead of a branch
#http://spin.atomicobject.com/2012/08/13/deploying-from-git-with-capistrano/
if exists?(:tag)
  set :branch, tag
else 
  set :branch, 'master'
  set :tag, 'master' 
end 

# keeping a clean house.
after "deploy:restart", "deploy:cleanup"


set :subdir, "barista"

namespace :bundle do

    desc "Checkout subdirectory and delete all the other stuff"
    task :install do
      print "WHATTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT"
        run "rm -rf /tmp/#{subdir} && mv #{current_release}/#{subdir}/ /tmp && rm -rf #{current_release}/* && mv /tmp/#{subdir}/* #{current_release} && rm -rf /tmp/#{subdir}"
        run "cd #{current_release}/ && bundle install --gemfile #{current_release}/Gemfile  --deployment --quiet --without development test"
    end
end