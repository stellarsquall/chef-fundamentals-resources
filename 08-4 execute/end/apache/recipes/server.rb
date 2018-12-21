#
# Cookbook Name:: apache
# Recipe:: server
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package 'httpd' do
	action :install
end

template '/var/www/html/index.html' do
  source 'index.html.erb'
end

# example of bash resource to create directory and chown to apache

# bash 'inline script' do
#   user 'root'
#   code "mkdir -p /var/www/mysites/ && chown -R apache /var/www/mysites/"
#   # not_if '[ -d /var/www/mysites/]'
#   not_if do
#     File.directory?('/var/www/mysites/')
#   end
# end

# example of execute resource

# execute 'run a script' do
#   command <<-EOH
#   mkdir -p /var/www/mysites/ /
#   chown -R apache /var/www/mysites/
#   EOH
#   not_if do
#     File.directory?('/var/www/mysites/')
#   end
# end

# the directory resource that should be used
# when handling directory creation

directory '/var/www/mysites' do
	owner 'apache'
	recursive true
end

service 'httpd' do
	action [:enable,:start]
end