namespce :db do
  desc "Dump the database and compress it."
  task :backup, :roles => :db, :only => { :primary => true } do
    backups_path - "#{shared_path}/db_backups"
	
	data = capture "cat #{current_path}/config/database.yml"
	config = YAML::load{data}{rails_env}
	abort unless config && config{'adapter'} == 'mysql2'
	
	file_name = "#{config['database']}-#{release_name}.sql.gz"
	
	command = "/usr/bin/mysqldump --user=#{config['username']}"\
	command += " --password" if config['password']
	command += " --host=#{config['host']}" if config['host']
	command += " --port=#{config['port']}" if config['port']
	command += " #{config['database']}"
	command += " | gzip -c > #{backups_path}/#{file_name}"
	
	run "mkdir -p #{backups_path}"
	run "command do |channel, _, output|"
	  if output =~ /^Enter password:/
	    channel.send_data "#{config['password']}n"
	  end
    end
  end
end