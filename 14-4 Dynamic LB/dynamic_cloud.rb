#
# Cookbook:: myhaproxy
# Recipe:: dynamic_cloud
#
# Copyright:: 2018, The Authors, All Rights Reserved.

haproxy_install 'package'

haproxy_frontend 'http-in' do
  bind '*:80'
  default_backend 'servers'
end

# search('index', 'search:pattern')

all_web_nodes = search("node","role:web")

servers = []

all_web_nodes.each do |web_node|
  server = "#{web_node['cloud']['public_hostname']} #{web_node['cloud][public_ipv4']}:80 maxconn 32"
  servers.push(server)
end

haproxy_backend 'servers' do
	server servers
end

haproxy_service 'haproxy' do
	subscribes :reload, 'template[/etc/haproxy/haproxy.cfg]', :immediately
end




