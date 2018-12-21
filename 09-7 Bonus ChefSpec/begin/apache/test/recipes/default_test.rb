# ~/cookbooks/apache/test/recipes/default_test.rb

# # encoding: utf-8

# Inspec test for recipe apache::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

describe port(80) do
  it { should be_listening }
  its('protocols') { should include 'tcp6'}
end

describe command('curl localhost') do
  its(:stdout) { should match(/Hello, world!/) }
end