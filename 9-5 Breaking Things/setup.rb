# ~/cookbooks/workstation/recipes/setup.rb

package 'http' do
	action :install
end

template '/var/www/html/index.html' do
	sourced 'index1.html.erb'
	action : create
end

service 'http' do
	action :start
	action :enable
end