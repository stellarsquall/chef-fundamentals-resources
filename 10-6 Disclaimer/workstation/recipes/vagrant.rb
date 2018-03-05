# if you found this recipe you're probably wondering what it's for!
# we do not cover ohai plugins in this class, but it's the process of modifying
# the information added to the node object at the beginning of a chef-client run.

# the vagrant-ohai plugin modifes the node['ipaddress'] attribute gathered by ohai
# to match what we define in the Vagrant file. Otherwise ohai will detect the internal
# ipaddress assigned by vagrant. This allows our load balancer to work with the
# virtual instances we manage later in the class.
#
# @see https://github.com/avishai-ish-shalom/vagrant-ohai
# @see https://docs.chef.io/ohai_custom.html
#

# execute sudo /etc/init.d/network restart to reload the networking interfaces
# this problem seems confined to Vagrant 1.9.1
# see vagrant issue https://github.com/mitchellh/vagrant/issues/8115

execute 'reload network interfaces' do
  command 'sudo /etc/init.d/network restart'
  not_if "ifconfig | grep 'eth0'"
end

# set plugin path for ohai if not already defined in /etc/chef/client.rb
# this is always set on a subsequent chef-client run because of ruby_block[configure ohai plugin path]
if ::Ohai::Config.ohai.nil?
  ::Ohai::Config['plugin_path'] << '/etc/chef/ohai_plugins' # old format
else
  ::Ohai::Config.ohai['plugin_path'] << '/etc/chef/ohai_plugins' # new format
end

# add vagrant-ohai plugin to the resource collection
#
# @see https://docs.chef.io/resource_ohai.html
#
ohai 'vagrant-ipaddress' do
	plugin 'ipaddress'
	action :nothing
end

# modify the client.rb file to include the plugin path for the vagrant-ohai plugin
# At the beginning of every chef-client run, the client.rb file is loaded. 
#
# @see https://docs.chef.io/config_rb_client.html
#
# This ruby_block resource modifies the client.rb to include the '/etc/chef/ohai_plugins'
# directory, with a guard to check if the file has already been modified.
#
# @see https://docs.chef.io/resource_common.html#guards
#
# When the client.rb file is modified, the notification adds 'ohai[vagrant-ohai]' to the
# resource collection, re-running ohai with the new plugin loaded. This ensures we have
# access to the node['ipaddress'] attribute during this chef-client run.
# 
ruby_block "configure ohai plugin path" do
  block do
    file = Chef::Util::FileEdit.new("/etc/chef/client.rb")
    file.insert_line_if_no_match("ohai.plugin_path << '/etc/chef/ohai_plugins'","ohai.plugin_path << '/etc/chef/ohai_plugins'")
    file.write_file
  end
  notifies :reload, 'ohai[vagrant-ipaddress]', :immediately
end
