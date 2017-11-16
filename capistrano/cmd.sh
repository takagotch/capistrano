sudo gem install capistrano
#capistrano cap
cap -V
#gemfile gemfile.lock
gem 'mysql2' --> gem 'pg'
gem "unicorn"
group :development do
  gem "capistrano-unicorn", require: false
end

bundle install
#capify Capfile
capify .

#Capfile
load 'deploy'
load 'deploy/assets'
load 'config/deploy'

#*config/deploy.rb*
require "bundler/capistrano"

set :application, "assagao"
set :rails_env,   "production"

server "example.com", :web, :app, :db, primary: true

#set :repository,             "git://git@github.com:takagotch/var/git/app.git"
set :local_repository,        "git://git@github.com:takagotch/var/git/app.git"
set :repository,              "file:///var/git/app.git"
set :scm,                     :git
set :branch,                  "master"
set :user,                    "app"
set :use_sudo,                false
set :deploy_to,               "/home/#{user}/#{rails_env}"
#set :deploy_via,             :remote_cache
set :deploy_via,              :copy
set :copy_cache,              true
set_options[:forward_agent] = true
#default_environment["PATH"] = "/opt/bin:$PATH"
#
#after "deploy:update", :roles => :app do
# run "/bin/cp #{shared_path}/config/database.yml #{release_path}/config/"
# run "/bin/cp #{shared_path}/config/unicorn.rb #{release_path}/config/"
# run "/bin/mkdir -p #{shared_path}/files"
# run "/bin/in -s #{shared_path}/files #{release_path}/public"
#end
#
#gem install xyz -- --abc=123
#config/deploy.rb
#before "bundle:install" do
# run "cd #{release_path} && /usr/local/bundle config build.xyz --abc=123"
#end
#
#gem "turbo-sprockets-rails3"
#bundle install
#
#config/deploy.rb
#role :web, "takagotch.com"
#role :app, "app1.takagotch.com", "app2.takagotch.com"
#role :db,  "app1.takagotch.com",  primariy: true
#set  :asset_roles, [ :web, :app ]

sudo gpasswd -a app git
#deploy:setup
cap deploy:setup

#database.yml
cd ~/production
mkdir shared/config
cp ~/rails_root/config/database.yml shared/config/
#config/deploy.rb
after "deploy:update", roles: :app do
  run "/bin/cp #{shared_path}/config/database.yml #{release_path}/config/"
end

cd ~/production
cp ~/rails_root/config/unicorn.rb shared/config
#config/deploy.rb
after "deploy:update", :roles => :app do
  run "/bin/cp #{shared_path}/config/database.yml #{release_path}/config/"
  rnn "/bin/cp #{shared_path}/config/unicorn.rb #{release_path}/config/"
end

#deploy:update
cd ~/app
cap deploy:update

git clone git://git@github.com:takagotch/var/git/app.git temp
cd ~/production
ls -l

#nginx
sudo service app start
#/etc/nginx/sites-available/app
#/home/app/rails_root/public
#/home/app/production/current/public
sudo service nginx reload

#deploy:restart
#nginx
#config/deploy.rb
require "capistrano-unicorn"

cap deploy:update
cap deploy:restart
