require 'json'
require 'yaml'

VAGRANTFILE_API_VERSION = "2"
confDir = $confDir ||= File.expand_path("./config")

homesteadYamlPath = confDir + "/Homestead.yaml"
homesteadJsonPath = confDir + "/Homestead.json"
afterScriptPath = confDir + "/after.sh"
aliasesPath = confDir + "/aliases"

require File.expand_path(File.dirname(__FILE__) + '/scripts/homestead.rb')

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	if File.exists? aliasesPath then
		config.vm.provision "file", source: aliasesPath, destination: "~/.bash_aliases"
	end

    if File.exists? homesteadYamlPath then
		Homestead.configure(config, YAML::load(File.read(homesteadYamlPath)), Vagrant.has_plugin?('vagrant-hostsupdater'))
    elsif File.exists? homesteadJsonPath then
        Homestead.configure(config, JSON.parse(File.read(homesteadJsonPath)), Vagrant.has_plugin?('vagrant-hostsupdater'))
    end


	if File.exists? afterScriptPath then
		config.vm.provision "shell", path: afterScriptPath
	end
end
