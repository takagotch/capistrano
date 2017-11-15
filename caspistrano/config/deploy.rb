namespace :deploy do
  desc "Disable the app, run migrations, and enable the app."
  task :upgrade do
    web.disable
	migrations
	web.enable
  end
end