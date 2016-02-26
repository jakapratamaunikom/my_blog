
Vagrant.configure('2') do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network :forwarded_port, guest: 3000, host: 4000

  config.ssh.forward_agent = true

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.cpus = 4
  end
  
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks", "cookbooks-additionals"]

    chef.add_recipe 'apt'
    chef.add_recipe 'build-essential'
    chef.add_recipe 'postgresql::client'
    chef.add_recipe 'postgresql::server'

    chef.add_recipe 'current_project'
    
    chef.add_recipe 'rvm::vagrant'
    chef.add_recipe 'rvm::system'
    chef.add_recipe 'rvm::user'

    chef.add_recipe "imagemagick"
    chef.add_recipe "imagemagick::devel"


    chef.json = {
      postgresql: {
        password: {
          postgres: 'postgres'
        }
      },
      rvm: {
        vagrant: {
          system_chef_client: '/opt/chef/bin/chef-client',
          system_chef_solo:   '/opt/chef/bin/chef-solo'
        },

        version: 'head',
        default_ruby: 'ruby-1.9.3-p547',
        user_default_ruby: 'ruby-1.9.3-p547',

        user_installs: [
          {
            user:   "vagrant",
            global: "ruby-2.2.1",
            default_ruby: "ruby-2.2.1",

            rubies: [
              "ruby-2.2.1",
              "ruby-2.2-head"
            ]
          }
        ]
      },

      git: {
        version: '2.5.3',
        url: 'https://nodeload.github.com/git/git/tar.gz/v2.5.3',
        checksum: ''
      }
    }
  end
   
end
