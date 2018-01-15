# ~/cookbooks/workstation/recipes/setup.rb

package 'nano'
# or package 'vim-enhanced'

package 'ntp'

package 'git' do
	action :install
end

file '/etc/motd' do
	content 'This server is the property of Chef
	HOSTNAME: <PASTE HOSTNAME HERE>
	IPADDRESS: <PASTE IPADDRESS HERE>
	CPU: <PASTE CPU MHZ HERE>
	MEMORY: <PASTE TOTAL MEMORY HERE>
  '
  action :create
end