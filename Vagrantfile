require "yaml";

#names of domains
domains = {
    frontend: 'frontend.example.com',
    backend: 'backend.example.com'
}

VAGRANT_CONFIG = YAML::load_file('./vagrant/setup.yml')

path_to_files = {
    local: VAGRANT_CONFIG['dir_config'] + 'config.yml',
    example: VAGRANT_CONFIG['dir_config'] + 'example.config.yml'
}

file = path_to_files[:example]

if File.exist?(path_to_files[:local])
    file = path_to_files[:local]
end

options = YAML::load_file(file)

puts "UP VAGRANT"

Vagrant.configure("2") do |config|
  config.vm.box = VAGRANT_CONFIG['box']
  config.vm.provider 'virtualbox' do |vb|
    # machine cpus count
    vb.cpus = options['cpus']
    # machine memory size
    vb.memory = options['memory']
    # machine name (for VirtualBox UI)
    vb.name = options['machine_name']
  end

  # machine name (for vagrant console)
  config.vm.define options['machine_name']

  # machine name (for guest machine console)
  config.vm.hostname = options['machine_name']

  # network settings
  config.vm.network 'private_network', ip: options['ip']

  # sync: folder 'yii2-app-advanced' (host machine) -> folder '/app' (guest machine)
  #config.vm.synced_folder VAGRANT_CONFIG['sync_folder'], VAGRANT_CONFIG['path_folder_vagrant'], owner: VAGRANT_CONFIG['user'], group: VAGRANT_CONFIG['group_user']

  #provision
  config.vm.provision :shell, path: VAGRANT_CONFIG['dir_provision'] + "install.sh"
end
