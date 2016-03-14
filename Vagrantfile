
Vagrant.configure('2') do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network :forwarded_port, guest: 3000, host: 2000

  config.ssh.forward_agent = true


  machines = {
    'blog01' => '192.168.33.11',
    # 'blog02' => '192.168.33.12',
    # 'blog03' => '192.168.33.13',
  }

  machines.each do |name, ip|
    config.vm.define name do |host|
      host.vm.hostname = "#{name}.dev"
      host.vm.network "private_network", ip: ip
      host.vm.network :forwarded_port, guest: 80, host: 80
    end
  end

  config.vm.provider :virtualbox do |vb|
    vb.memory = "2048"
    vb.cpus = 1
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

    chef.add_recipe "java"
    chef.add_recipe "elasticsearch"

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
            ]
          }
        ]
      },

      git: {
        version: '2.5.3',
        url: 'https://nodeload.github.com/git/git/tar.gz/v2.5.3',
        checksum: ''
      },
      java: {
        jdk_version: "7",
      },
      elasticsearch: {
        deb_url: "https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.2.0/elasticsearch-2.2.0.deb",
        deb_sha: "8e862d77477fdc75963b225a622313b54c914cb4"
      }
    }
  end

  config.exec.commands 'bundle'
  config.exec.commands %[rails], prepend: 'bundle exec', directory: '/vagrant'
  config.exec.commands %[rspec], prepend: 'RAILS_ENV=test bundle exec', directory: '/vagrant'

  config.vm.provision "shell", inline: "sudo su - vagrant -c \"git config --global user.email '17valexl@gmail.com'\""
  config.vm.provision "shell", inline: "sudo su - vagrant -c \"git config --global user.name 'Alexey Volobuev'\""

  config.vm.provision "shell" do |s| #copy ssh keys from current machine  
    ssh_pub_key = File.read("#{Dir.home}/.ssh/id_rsa.pub")
    ssh_private_key = File.read("#{Dir.home}/.ssh/id_rsa")
    s.inline = <<-SHELL
      echo -n "" > ~/.ssh/id_rsa
      echo -n "" > ~/.ssh/id_rsa.pub
      echo '#{ssh_pub_key}' > /home/vagrant/.ssh/id_rsa.pub
      echo '#{ssh_private_key}' > /home/vagrant/.ssh/id_rsa
    SHELL
  end

end
