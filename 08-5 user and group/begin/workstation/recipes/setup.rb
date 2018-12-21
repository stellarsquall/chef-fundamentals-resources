#
# Cookbook Name:: workstation
# Recipe:: setup
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# ~/cookbooks/workstation/recipes/setup.rb

package 'nano'
# or package 'vim-enhanced'
package 'ntp'

package 'tree' do
	action :install
end

package 'git' do
	action :install
end

template '/etc/motd' do
  source 'motd.erb'
  action :create
end