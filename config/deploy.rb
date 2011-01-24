default_run_options[:pty] = true  # Must be set for the password prompt from git to work
ssh_options[:forward_agent] = true

set :rake,    '~/ruby1.8/lib/ruby/gems/1.8/bin/rake'
set :bundle,   '/home/niftykit/ruby1.8/lib/ruby/gems/1.8/bin/bundle'

set :application, "votie"
set :repository, "git@github.com:klepas/#{application}.git"
set :deploy_to,   "/home/niftykit/webapps/votie_2011/#{application}"
set :use_sudo,    false
set :user,        'niftykit'

set :scm,         :git
set :scm_command, "~/bin/git"
set :local_scm_command, "/usr/bin/git"

default_environment["PATH"] = "$PATH:/home/niftykit/bin"
default_environment["GEM_HOME"] = "#{deploy_to}/../gems"
default_environment["GEM_PATH"] = "#{deploy_to}/../gems"

role :web, "votieapp.org"                           # Your HTTP server, nginx/Apache/etc
role :app, "votieapp.org"                           # This may be the same as your `Web` server
role :db,  "votieapp.org", :primary => true         # This is where Rails migrations will run

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end
  
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
  
  desc "run 'rake db:seed' in production"
  task :load_seed do
    run "cd #{current_release} &&  #{rake} db:seed"
  end
end

namespace :migrations do
  task :redo, :roles => :app do
    run("cd #{current_release} && #{rake} db:migrate VERSION=00 RAILS_ENV=production && #{rake} db:migrate RAILS_ENV=production")
  end
end

namespace :db do
  task :seed, :roles => :app do
    run("cd #{current_release} && #{rake} db:seed RAILS_ENV=production")
  end
  task :reset, :roles => :app do
    run("cd #{current_release} && #{rake} db:reset RAILS_ENV=production")
  end
  task :migrate, :roles => :app do
    run("cd #{current_release} && #{rake} db:migrate RAILS_ENV=production")
  end
end

namespace :bundler do
  task :install, :roles => :app do
    run "cd #{current_release} && #{bundle} install --without development"
  end

  task :create_symlink, :roles => :app do
    shared_dir = File.join(shared_path, 'bundle')
    release_dir = File.join(current_release, '.bundle')
    run("mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_dir}")
  end
  
  task :bundle_new_release, :roles => :app do
    bundler.create_symlink
    run "cd #{release_path} && #{bundle} install --without development"
  end
  
  task :lock, :roles => :app do
    run "cd #{current_release} && #{bundle} lock;"
  end
  
  task :unlock, :roles => :app do
    run "cd #{current_release} && #{bundle} unlock;"
  end
end

after "deploy:update_code" do
  bundler.bundle_new_release
  deploy.symlink_shared
  # deploy.migrations
  # deploy.load_seed
  # ...
end
# after 'deploy:update_code', 'deploy:symlink_shared' #, 'deploy:migrations', 'deploy:load_seed'
