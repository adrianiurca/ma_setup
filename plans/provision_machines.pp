plan ma_setup::provision_machines (
  Optional[String] $provisioner = 'abs',
  Optional[String] $master = 'centos-7-x86_64',
  Optional[Array[String]] $agent_oses = ['centos-7-x86_64']
) {
  # provision master
  run_task(
    "provision::${provisioner}",
    'localhost',
    "provision master(${master})",
    { 'action' => 'provision', 'platform' => $master, 'vars' => 'role: server' }
  )

  # provision agents
  $agent_oses.each |$os| {
    run_task(
      "provision::${provisioner}",
      'localhost',
      "provision agent(${os})",
      { action => 'provision', platform => $os, vars => 'role: agent' }
    )
  }
}
