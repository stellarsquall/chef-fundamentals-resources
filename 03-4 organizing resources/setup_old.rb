

package 'tree' do
	action :install
end

package 'ntp'

file '/etc/motd' do
	content 'This server is the property of ...'
end

service 'ntpd' do
	action [:enable, :start]
end