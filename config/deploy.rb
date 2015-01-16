# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'ratings'
set :repo_url, '/home/git/ratings.git'
set :deploy_to, "/var/app/#{fetch(:application)}"
set :keep_releases, 5

set :rbenv_typem, :system
set :rbenv_ruby, '2.1.4'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w(rake gem bundle ruby rails)
set :rbenv_roles, :all

set :linked_dirs, %w{bin log tmp/backup tmp/pids tmp/cache tmp/sockets vendor/bundle}
set :unicorn_pid, "/var/run/unicorn/unicorn_ratings.pid"

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
