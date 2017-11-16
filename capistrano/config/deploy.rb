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
#@@@@@
namespace :deploy do
  desc "Disable the app, run migrations, and enable the app."
  task :upgrade do
    web.disable
	migrations
	web.enable
  end
end