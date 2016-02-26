psql_user "vagrant" do
  password "vagrant"
  admin_username 'postgres'
  admin_password node['postgresql']['password']['postgres']
  grant_create_db true
  host "127.0.0.1"
end

psql_database "my_blog_development" do
  owner "vagrant"
  admin_username 'postgres'
  admin_password node['postgresql']['password']['postgres']
  host "127.0.0.1"
end

psql_database "my_blog_test" do
  owner "vagrant"
  admin_username 'postgres'
  admin_password node['postgresql']['password']['postgres']
  host "127.0.0.1"
end





