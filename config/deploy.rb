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
end
