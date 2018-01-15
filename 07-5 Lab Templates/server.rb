# ~/cookbooks/apache/recipes/server.rb

package 'httpd' do
	action :install
end

template '/var/www/html/index.html' do
  source 'index.html.erb'
end

service 'httpd' do
	action [:enable,:start]
end