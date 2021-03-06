unless Vagrant.has_plugin?("vagrant-windows")
  raise 'vagrant-windows is not installed!'
end

Vagrant.configure("2") do |config|
  config.vm.provider :virtualbox do |v|
    v.gui = true
  end

  config.vm.provider :vmware_fusion do |v|
    v.gui = true
  end

  config.windows.halt_timeout = 20
  config.winrm.username = "vagrant"
  config.winrm.password = "vagrant"
  config.vm.guest = :windows

  # Port forward WinRM and RDP
  config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
  #config.vm.network :forwarded_port, guest: 3389, host: 3389

  #from the perspective of the box itself, not the current directory
  config.vm.synced_folder "../shared", "/vagrantshared"

  # config.vm.synced_folder "~", "/home"
  # config.vm.synced_folder "puppet/box_modules", "/ProgramData/PuppetLabs/puppet/etc/modules"

  # # This shell provisioner installs chocolatey, ruby, and puppet. Also runs librarian-puppet.
  # config.vm.provision :shell, :path => "shell/main.cmd"

  # # Enable provisioning with Puppet stand alone.  Puppet manifests
  # # are contained in a directory path relative to this Vagrantfile.
  # config.vm.provision :puppet, :options => ["--debug --trace --verbose"] do |puppet|
  #   puppet.manifests_path = "puppet/manifests"
  #   puppet.manifest_file  = "site.pp"
  #   puppet.module_path = "puppet/modules"
  #   puppet.facter = {
  #     "domain" => "local",
  #     "kernel" => "windows",
  #     "operatingsystem" => "windows",
  #     "osfamily" => "windows",
  #   }
  # end
  #
  # net stop puppet
  # rename puppet puppet.old
  # mklink "C:\Program Files (x86)\Puppet Labs\Puppet\puppet" c:\code\puppetlabs\puppet
end
