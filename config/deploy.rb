# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'ratings'
set :repo_url, 'ssh://git@49.212.196.57:16880/home/git/ratings.git'
set :deploy_to, "/var/app/#{fetch(:application)}"
set :keep_releases, 5

set :rbenv_typem, :user
set :rbenv_ruby, '2.1.4'
set :rbenv_map_bins, %w(rake gem bundle ruby rails)
set :rbenv_roles, :all

set :linked_dirs, %w{bin log tmp/backup tmp/pids tmp/cache tmp/sockets vendor/bundle public/assets}
set :unicorn_pid, "/var/run/unicorn/unicorn_ratings.pid"

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'db:creat'
  task :db_create do
    on roles(:app) do |h|
      execute "cd #{fetch(:deploy_to)}/current && RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec bundle exec rake RAILS_ENV=production db:create"
    end
  end

  desc 'db:migrate:reset'
  task :db_migrate_reset do
    on roles(:app) do |h|
      execute "cd #{fetch(:deploy_to)}/current && RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec bundle exec rake RAILS_ENV=production db:migrate:reset"
    end
  end
end
