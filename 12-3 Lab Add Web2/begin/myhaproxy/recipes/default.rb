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
  	# 'server2 127.0.0.1:8000 maxconn 32'
  ]
  # notifies :restart, 'haproxy_service[haproxy]'
  # this doesn't seem to work. Using subscribes in haproxy_service[haproxy] instead per
  # https://github.com/sous-chefs/haproxy/issues/274
end

haproxy_service 'haproxy' do
	subscribes :reload, 'template[/etc/haproxy/haproxy.cfg]', :immediately
end