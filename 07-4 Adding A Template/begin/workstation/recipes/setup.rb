#
# Cookbook Name:: workstation
# Recipe:: setup
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package 'nano'
# or package 'vim-enhanced'

package 'ntp'

package 'git' do
	action :install
end

file '/etc/motd' do
	content "This server is the property of Chef
	HOSTNAME: #{node['hostname']}
	IPADDRESS: #{node['ipaddress']}
	CPU: #{node['cpu']['0']['mhz']}
	MEMORY: #{node['memory']['total']}
  "
  action :create
end