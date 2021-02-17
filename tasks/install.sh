#!/bin/sh

if [[ -n "$PT_version" ]]; then
  version = $PT_version
else
  version = 'latest'
fi

if [[ -n "$PT_node" ]]; then
  node = $PT_node
fi

curl -o puppet.rpm http://yum.puppetlabs.com/puppet6/puppet6-release-el-7.noarch.rpm
if test $? -ne 0; then
  echo 'curl failed to download http://yum.puppetlabs.com/puppet6/puppet6-release-el-7.noarch.rpm'
  exit 1
fi
rpm -Uvh puppet.rpm --quiet
yum install puppetserver -y --quiet