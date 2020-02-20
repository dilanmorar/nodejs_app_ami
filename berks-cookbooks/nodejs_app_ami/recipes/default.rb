#
# Cookbook:: nodejs_app_ami
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

# imports
include_recipe 'apt'
include_recipe 'nodejs'

# apt updates
apt_update 'update sources' do
  action :update
end

package 'nginx'
# package 'npm'

# npm installs
nodejs_npm 'pm2'

# resource services+
service 'nginx' do
  action [:enable, :start]
end

# resource template
template '/etc/nginx/sites-available/proxy.conf' do
  source 'proxy.conf.erb'
  variables proxy_port: 3000
  notifies :restart, 'service[nginx]'
end

# resource link
link '/etc/nginx/sites-enabled/proxy.conf' do
  to '/etc/nginx/sites-available/proxy.conf'
  notifies :restart, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/default' do
  action :delete
  notifies :restart, 'service[nginx]'
end
