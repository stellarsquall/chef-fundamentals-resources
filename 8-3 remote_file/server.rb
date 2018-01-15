# ~/cookbooks/apache/recipes/server.rb

package 'httpd' do
	action :install
end

remote_file '/var/www/html/chef.png' do
  source 'https://brand.chef.io/images/chef/logos/logo-2.svg'
end

template '/var/www/html/index.html' do
  source 'index.html.erb'
end

service 'httpd' do
	action [:enable,:start]
end