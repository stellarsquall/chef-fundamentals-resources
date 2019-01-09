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
  	'server1 127.0.0.1:8000 maxconn 32',
  	'server2 127.0.0.1:8000 maxconn 32'
  ]
end

haproxy_service 'haproxy'