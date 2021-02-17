plan ma_setup::agents(
  Optional[String] $collection = 'puppet6'
) {
  # get agents and server
  $agents = get_targets('*').filter |$node| { $node.vars['role'] == 'agent' }
  $server = get_targets('*').filter |$node| { $node.vars['role'] == 'server' }

  # install puppet-agent and configure
  $agents.each |$agent| {
    run_task('puppet_agent::install', $agent, 'install agent', { 'collection' => $collection })
    apply($agent, '_catch_errors' => true, 'description' => 'configure agent') {
      # class { 'puppet_agent': package_version => '6.21.0', collection => 'puppet6' }
      file { '/etc/puppetlabs/puppet/puppet.conf':
        ensure  => file,
        content => epp('ma_setup/puppet-agent.conf', { server_name => $server[0].name, agent_name => $agent.name }),
        # require => Class['Puppet_agent'],
      }
    }
    # agent sign request
    run_command('puppet agent -t', $agent, '_catch_errors' => true)
  }

  ctrl::sleep(3)

  # sign all certificates
  run_command('puppetserver ca sign --all', $server, '_catch_errors' => true)
}
