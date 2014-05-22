#
# Cookbook Name:: tizen
# Recipe:: default
#
# Copyright 2014, Joe Richards
#

include_recipe 'java'

package 'redhat-lsb-core'

remote_file "#{Chef::Config[:file_cache_path]}/tizen-wearable-sdk-install-manager-#{node['tizen']['wearable-sdk']['version']}.bin" do
    source node['tizen']['wearable-sdk']['install-manager']['url']
    checksum node['tizen']['wearable-sdk']['install-manager']['checksum']
    mode 00755
    action :create
end

bash 'install_tizen_wearable_sdk' do
    cwd Chef::Config[:file_cache_path]
    user  node['tizen']['wearable-sdk']['user']
    group node['tizen']['wearable-sdk']['group']
    code <<-EOH
        export HOME=`echo ~#{node['tizen']['wearable-sdk']['user']}`
        cd #{Chef::Config[:file_cache_path]}
        mkdir -p ${HOME}/bin
        echo '/bin/true' > ${HOME}/bin/xdg-desktop-menu
        chmod +x ${HOME}/bin/xdg-desktop-menu
        export PATH=$PATH:${HOME}/bin
        export DISPLAY=:0
        ./tizen-wearable-sdk-install-manager-#{node['tizen']['wearable-sdk']['version']}.bin -install -r http://download.tizen.org/sdk/packages -d official -p MINIMAL -accept_license
        rm -f ${HOME}/bin/xdg-desktop-menu
        rmdir ${HOME}/bin
    EOH
    not_if { ::File.exists?("#{node['tizen']['wearable-sdk']['home']}-#{node['tizen']['wearable-sdk']['version']}") }
    notifies :run, 'bash[link_tizen_sdk]', :immediately
end

file '/etc/init.d/tizen-kvm' do
    action :delete
end

bash 'link_tizen_sdk' do
    cwd Chef::Config[:file_cache_path]
    code <<-EOH
        mv ~#{node['tizen']['wearable-sdk']['user']}/tizen-wearable-sdk #{node['tizen']['wearable-sdk']['home']}-#{node['tizen']['wearable-sdk']['version']}
        rm -f #{node['tizen']['wearable-sdk']['home']}
        ln -s #{node['tizen']['wearable-sdk']['home']}-#{node['tizen']['wearable-sdk']['version']} #{node['tizen']['wearable-sdk']['home']}

        mv ~#{node['tizen']['wearable-sdk']['user']}/tizen-wearable-sdk-data #{node['tizen']['wearable-sdk']['home']}-data-#{node['tizen']['wearable-sdk']['version']}
        rm -f #{node['tizen']['wearable-sdk']['home']}-data
        ln -s #{node['tizen']['wearable-sdk']['home']}-data-#{node['tizen']['wearable-sdk']['version']} #{node['tizen']['wearable-sdk']['home']}-data

        find #{node['tizen']['wearable-sdk']['home']}-#{node['tizen']['wearable-sdk']['version']}/tools -maxdepth 1 -type l -delete
        ln -s #{node['tizen']['wearable-sdk']['home']}-#{node['tizen']['wearable-sdk']['version']}/tools/ide/bin/web* #{node['tizen']['wearable-sdk']['home']}-#{node['tizen']['wearable-sdk']['version']}/tools
    EOH
    action :nothing
end

template "#{node['tizen']['wearable-sdk']['home']}-#{node['tizen']['wearable-sdk']['version']}/sdk.info" do
    source 'sdk.info.erb'
    variables ({
        :sdk_path => "#{node['tizen']['wearable-sdk']['home']}-#{node['tizen']['wearable-sdk']['version']}",
        :sdk_data_path => "#{node['tizen']['wearable-sdk']['home']}-data-#{node['tizen']['wearable-sdk']['version']}"
    })
    mode 00644
    only_if { ::File.exists?("#{node['tizen']['wearable-sdk']['home']}-#{node['tizen']['wearable-sdk']['version']}") }
end

file '/etc/profile.d/tizen-wearable-sdk.sh' do
    content "export TIZENWEARABLE_HOME=/usr/local/tizen-wearable-sdk/\nexport PATH=\"${PATH}:${TIZENWEARABLE_HOME}tools\""
    mode 00755
    owner 'root'
    group 'root'
end
