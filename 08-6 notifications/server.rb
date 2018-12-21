# ~/cookbooks/apache/recipes/server.rb

# notifies :action, 'resource[name]', :timer
# subscribes :action, 'resource[name]', :timer

# timer :before, :delayed, :immediately


package 'httpd' do
	action :install
end

template '/var/www/html/index.html' do
  source 'index.html.erb'
  notifies :restart, 'service[httpd]', :immediately
end

service 'httpd' do
	action [:enable,:start]
	subscribes :restart, 'template[/var/www/html/index.html]', :immediately
end