plan ma_setup::server() {
  # get server
  $server = get_targets('*').filter |$node| { $node.vars['role'] == 'server' }

  # install puppetserver and start on master
  run_task(
    'ma_setup::install',
    $server,
    'install and configure server'
  )

  apply($server, 'description' => 'write puppet.conf') {
    file { '/etc/puppetlabs/puppet/puppet.conf':
      ensure  => file,
      content => epp('ma_setup/puppetserver.conf', { server_name => $server[0].name }),
    }
  }

  run_command('systemctl start puppetserver', $server, '_catch_errors' => true)
  run_command('systemctl enable puppetserver', $server, '_catch_errors' => true)
}
