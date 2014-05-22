#
# Cookbook Name:: tizen
# Recipe:: default
#
# Copyright 2014, Joe Richards
#

include_recipe 'yum'

yum_repository 'tizen' do
    description 'Tizen build tools'
    baseurl 'https://download.tizen.org/tools/latest-release/CentOS_6/'
    gpgcheck false
    action :create
end

package 'gbs'
package 'mic'
