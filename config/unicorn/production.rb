application = 'ratings'

worker_processes 2
working_directory "/var/app/#{application}/current"

listen "/var/run/unicorn/unicorn_#{application}.sock"   # Unix Domain Socket

pid "/var/run/unicorn/unicorn_#{application}.pid"       # PIDファイル出力先

timeout 60

preload_app true

stdout_path File.join(Dir.pwd, "log", "unicorn-out.log")
stderr_path File.join(Dir.pwd, "log", "unicorn-err.log")

GC.respond_to?(:copy_on_write_friendly=) and GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
    if old_pid != server.pid
      begin
        sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
        Process.kill(sig, File.read(old_pid).to_i)
      rescue Errno::ENOENT, Errno::ESRCH
      end
    end

    sleep 1
  end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
