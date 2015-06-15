if Rails.env.development? || Rails.env.test?
  bind  "tcp://0.0.0.0:3000"
  pidfile "tmp/puma/pid"
  state_path "tmp/puma/state"
  threads 4,4
else
  bind  "tcp://91.218.229.116:4444"
  pidfile "/var/www/my_blog/current/tmp/puma_pid"
  state_path "/var/www/my_blog/current/tmp/puma_state" 
  threads 0,1000
  # workers 1
  # preload_app!
end

activate_control_app
