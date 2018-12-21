# chef-repo/cookbooks/myhaproxy/recipes/default.rb
#
# Cookbook Name:: myhaproxy
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

node.default['haproxy']['members'] = [{
    'hostname' => 'WEB1_HOSTNAME', # these values come from the Vagrantfile
    'ipaddress' => 'WEB1_IPADDRESS', # or the public IP and hostname is using a cloud provider
    'port' => 80,
    'ssl_port' => 80
  }
]

include_recipe 'haproxy::manual'