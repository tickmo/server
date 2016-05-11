# set path to application
app_dir = File.expand_path('../..', __FILE__)
shared_dir = "#{app_dir}/shared"
working_directory app_dir

# Set unicorn options
worker_processes 2
preload_app true
timeout 30

# Set up socket location
listen "#{shared_dir}/sockets/app.sock", backlog: 64

# Logging
stderr_path "#{shared_dir}/log/app.stderr.log"
stdout_path "#{shared_dir}/log/app.stdout.log"

# Set master PID location
pid "#{shared_dir}/pids/app.pid"
