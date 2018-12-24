#
# Cookbook:: myhaproxy
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

haproxy_install 'package'

haproxy_frontend 'http-in' do
  bind '*:80'
  default_backend 'servers'
end

haproxy_backend 'servers' do
  server [
  	'web1 192.168.10.43:80 maxconn 32',
  	'web2 192.168.10.44:80 maxconn 32'
  ]
end

haproxy_service 'haproxy' do
	subscribes :reload, 'template[/etc/haproxy/haproxy.cfg]', :immediately
end