#
# Cookbook Name:: rackspace_user
# Recipe:: rack_user
#
# Copyright (C) 2014 Rackspace, US Inc.
#
# All rights reserved - Do Not Redistribute
#

user node['rackspace_user']['rack_user']['user'] do
  home node['rackspace_user']['rack_user']['home_folder']
  shell node['rackspace_user']['rack_user']['shell']
  if node['rackspace_user']['rack_user'].key? 'password_hash'
    password node['rackspace_user']['rack_user']['password_hash']
  end
end

directory node['rackspace_user']['rack_user']['home_folder'] do
  owner node['rackspace_user']['rack_user']['user']
  group node['rackspace_user']['rack_user']['user']
  mode '0700'
  action :create
end

directory "#{node['rackspace_user']['rack_user']['home_folder']}/.ssh" do
  owner node['rackspace_user']['rack_user']['user']
  group node['rackspace_user']['rack_user']['user']
  mode  '0700'
  action :create
end

remote_file "#{node['rackspace_user']['rack_user']['home_folder']}/.ssh/authorized_keys" do
  owner node['rackspace_user']['rack_user']['user']
  group node['rackspace_user']['rack_user']['user']
  source 'https://raw.github.com/rackops/authorized_keys/master/authorized_keys'
  action :create
end
