require "bundler/capistrano"

set :application, "esthe"
set :rails_env, "production"

server "tsuiseki-kun.co.jp" ,:web, :app, :db, primary: true
#server "160.16.53.5" ,:web, :app, :db, primary: true
#set :repository, "ssh://git@bitbucket.org/masafumi_sougumo/esthe.git"
set :repository, "https://github.com/masapostman/esthe.git"
set :scm, :git
set :branch, "master"
set :user, "esthe"
set :use_sudo, false
set :deploy_to, "/home/#{user}/#{rails_env}"
set :deploy_via, :remote_cache

set :linked_files, %w{ config/secrets.yml }

ssh_options[:forward_agent] = true

before "deploy:assets:precompile", roles: :app do
        run "/bin/cp #{shared_path}/config/database.yml #{release_path}/config/"
end

namespace :deploy do
        desc "Restart esthe application"
        task :restart do
                run "mkdir -p #{shared_path}/tmp"
                run "touch #{shared_path}/tmp/restart.txt"
        end
end

after "deploy", :except => { :no_release => true } do
	deploy.cleanup
end
