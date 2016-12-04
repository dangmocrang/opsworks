#
# Cookbook Name:: jboss
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# install java_se jdk

# install java jdk and jboss
include_recipe 'aws'
jboss = 'jboss-as-7.1.1.Final'
jdk = 'jdk-7u80-linux-x64.tar.gz'
region = 'ap-southeast-1'
bucket = 'bu33'

# install and configure jboss
aws_s3_file '/tmp/#{jboss}' do
  bucket bucket
  remote_path 'system/#{jboss}.tar.gz'
  region region
end

bash 'jboss-setup' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  tar -zxf /tmp/#{jboss}.tar.gz --directory /opt
  useradd -r jboss -d /opt/#{jboss}
  chown jboss: -R /opt/#{jboss}
  cp /opt/#{jboss}/bin/init.d/jboss-as-standalone.sh /etc/init.d/jboss
  chmod +x /etc/init.d/jboss
  mkdir /etc/jboss-as
  echo "JBOSS_HOME=/opt/jboss-as-7.1.1.Final" >> /etc/jboss-as/jboss-as.conf
  echo "JBOSS_CONSOLE_LOG=/var/log/jboss-console.log" >> /etc/jboss-as/jboss-as.conf
  echo "JBOSS_USER=jboss" >> /etc/jboss-as/jboss-as.conf
  EOH
end

execute 'jboss-extract' do
  command 'tar xzf /tmp/#{jboss} --directory /opt'
  action :run
end


execute 'jboss-remove-source' do
  command 'rm -f /tmp/#{jboss}'
  action :run
end
