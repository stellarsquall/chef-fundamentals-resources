# This is an example of the file you should have written on your vagrant or cloud instance
# The path of the recipe is '/hello.rb'
# This ruby file will be run with the command 'sudo chef-client --local-mode hello.rb'
# The result is that a file, hello.txt, will be created in the root directory
# with the content "Hello, world!"

#
# The file, named '/hello.txt' is created
#   with the content 'Hello, world!'
#
# @see https://docs.chef.io/resource_file.html
#

file '/hello.txt' do
	content 'Hello, world!'
end