#
# Cookbook Name:: jboss
# Recipe:: deploy
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
include_recipe 'aws'

search("aws_opsworks_app").each do |app|
  if app['environment']['layer'] == 'app-cvdb'
    appSource = app['app_source']['url']
    appBucket = app['environment']['bucket']
    appPath = app['environment']['app_path']
    appRegion = app['environment']['region']
    break
  end
end

aws_s3_file '/web/jboss/standalone/deployments/ROOT.war' do
  bucket $appBucket
  remote_path $appPath
  region $appRegion
end 
