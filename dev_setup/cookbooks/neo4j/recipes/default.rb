#
# Cookbook Name:: neo4j
# Recipe:: default
#
# Copyright 2011, VMware
#

node[:neo4j][:supported_versions].each do |version, install_version|
  #TODO, need more refine to actually support mutiple versions
  Chef::Log.info("Building neo4j version: #{version} - #{install_version}")

  [node[:neo4j][:service_dir], File.join(node[:neo4j][:service_dir], "instances")].each do |dir|
    directory dir do
      owner node[:deployment][:user]
      group node[:deployment][:group]
      mode "0755"
    end
  end

  remote_file File.join(node[:neo4j][:service_dir], "neo4j-server.tgz") do
    owner node[:deployment][:user]
    source "http://dist.neo4j.org/neo4j-community-#{version}-unix.tar.gz"
  end

  remote_file File.join(node[:neo4j][:service_dir], "neo4j-hosting-extension.jar") do
    owner node[:deployment][:user]
    source "http://cl.ly/220s0j0W2w0E/download/neo4j-hosting-extension-1.7.2.jar"
  end
end
