require 'json'
require 'yaml'

VAGRANTFILE_API_VERSION = "2"

homesteadYamlPath = File.expand_path("./config/Homestead.yaml")
afterScriptPath = File.expand_path("./config/after.sh")
aliasesPath = File.expand_path("./config/aliases")

require_relative 'scripts/homestead.rb'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	config.ssh.username = "vagrant"
	config.ssh.password = "vagrant"

	if File.exists? aliasesPath then
		config.vm.provision "file", source: aliasesPath, destination: "~/.bash_aliases"
	end

	Homestead.configure(config, YAML::load(File.read(homesteadYamlPath)))

	if File.exists? afterScriptPath then
		config.vm.provision "shell", path: afterScriptPath
	end
end
