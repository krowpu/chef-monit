include_recipe 'nginx'

include_recipe 'dist-update'

package 'monit'

service 'monit' do
  action :nothing
end

service 'nginx' do
  action :nothing
end

cookbook_file '/etc/monit/monitrc' do
  source 'monitrc.erb'
  owner 'root'
  group 'root'
  mode '0600' # -rw-------

  notifies :restart, 'service[monit]'
end

cookbook_file '/etc/nginx/snippets/monit.conf' do
  source 'nginx.conf'
  owner 'root'
  group 'root'
  mode '0644' # -rw-r--r--

  notifies :restart, 'service[nginx]'
end

template '/etc/monit/conf-available/system' do
  source 'system.erb'
  owner 'root'
  group 'root'
  mode '0644' # -rw-r--r--

  notifies :restart, 'service[monit]'

  variables name: node['monit']['system_name']
end

link '/etc/monit/conf-enabled/system' do
  to '/etc/monit/conf-available/system'
  owner 'root'
  group 'root'

  notifies :restart, 'service[monit]'
end

cookbook_file '/etc/monit/conf-available/rootfs' do
  source 'rootfs'
  owner 'root'
  group 'root'
  mode '0644' # -rw-r--r--

  notifies :restart, 'service[monit]'
end

link '/etc/monit/conf-enabled/rootfs' do
  to '/etc/monit/conf-available/rootfs'
  owner 'root'
  group 'root'

  notifies :restart, 'service[monit]'
end

cookbook_file '/etc/monit/conf-available/sshd' do
  source 'sshd'
  owner 'root'
  group 'root'
  mode '0644' # -rw-r--r--

  notifies :restart, 'service[monit]'
end

link '/etc/monit/conf-enabled/sshd' do
  to '/etc/monit/conf-available/sshd'
  owner 'root'
  group 'root'

  notifies :restart, 'service[monit]'
end

cookbook_file '/etc/monit/conf-available/monit' do
  source 'monit'
  owner 'root'
  group 'root'
  mode '0644' # -rw-r--r--

  notifies :restart, 'service[monit]'
end

link '/etc/monit/conf-enabled/monit' do
  to '/etc/monit/conf-available/monit'
  owner 'root'
  group 'root'

  notifies :restart, 'service[monit]'
end

cookbook_file '/etc/monit/conf-available/nginx' do
  source 'nginx'
  owner 'root'
  group 'root'
  mode '0644' # -rw-r--r--

  notifies :restart, 'service[monit]'
end

link '/etc/monit/conf-enabled/nginx' do
  to '/etc/monit/conf-available/nginx'
  owner 'root'
  group 'root'

  notifies :restart, 'service[monit]'
end
