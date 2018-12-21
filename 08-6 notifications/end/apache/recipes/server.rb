#
# Cookbook Name:: apache
# Recipe:: server
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

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
# pick notifies or subscribes, not both	
#	subscribes :restart, 'template[/var/www/html/index.html]', :immediately
end