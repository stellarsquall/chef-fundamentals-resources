#
# Cookbook Name:: myhaproxy
# Recipe:: cloud_default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#
# This recipe is for using the public hostname and public ipaddress
# on any cloud instance, such as AWS, Azure or GCP

all_web_nodes = search('node',"role:web AND chef_environment:#{node.chef_environment}")

members = []

all_web_nodes.each do |web_node|

  member = {
  	'hostname'  => web_node['cloud']['public_hostname'],
  	'ipaddress' => web_node['cloud']['public_ipv4'],
  	'port' => 80,
  	'ssl_port' => 80
  }

  members.push(member)

end

node.default['haproxy']['members'] = members

include_recipe "haproxy::manual"