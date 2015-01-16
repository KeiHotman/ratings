set :stage, :production
set :branch, 'master'

role :app, %w(49.212.196.57)
#role :web, %w(app@49.212.196.57)
#role :db,  %w(app@49.212.196.57)

set :ssh_options, {
  keys: [File.expand_path('~/.ssh/id_rsa')],
  forward_agent: false,
  auth_methods: %w(publickey),
  port: 16880
}

server '49.212.196.57',
  user: 'app',
  roles: %w(app),
  ssh_options: fetch(:ssh_options)

set :unicorn_rack_env, :production
