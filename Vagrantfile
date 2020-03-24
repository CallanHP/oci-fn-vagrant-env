# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/bionic64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  
  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  
  #Install docker and Fn
  config.vm.provision "shell", reset: true, inline: <<-SHELL
    apt-get update -y
    apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common libseccomp2
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    apt-get update -y
    apt-get install -y docker-ce containerd.io
    usermod -aG docker vagrant
    curl -LSs https://raw.githubusercontent.com/fnproject/cli/master/install | sh
  SHELL

  #Uncomment to copy API keys in from a local source if you dont want to use the shared vagrant folder.
  #config.vm.provision "file", source: "api_key.pem", destination: "/home/vagrant/.oci/api_key.pem"

  #set OCI environment variables
  $oci_script = "/bin/bash --login /vagrant/scripts/configure-oci.sh"
  config.vm.provision "shell", privileged: false, inline: $oci_script

  #Set up Fn contexts (using the vagrant user context)
  $fn_script = "/bin/bash --login /vagrant/scripts/configure-fn.sh"
  config.vm.provision "shell", privileged: false, inline: $fn_script

end
