require 'spec_helper'
require 'shared_contexts'

describe 'ssh' do
  # by default the hiera integration uses hiera data from the shared_contexts.rb file
  # but basically to mock hiera you first need to add a key/value pair
  # to the specific context in the spec/shared_contexts.rb file
  # Note: you can only use a single hiera context per describe/context block
  # rspec-puppet does not allow you to swap out hiera data on a per test block
  #include_context :hiera


  # below is the facts hash that gives you the ability to mock
  # facts on a per describe/context block.  If you use a fact in your
  # manifest you should mock the facts below.
  let(:facts) do
    {}
  end
  # below is a list of the resource parameters that you can override.
  # By default all non-required parameters are commented out,
  # while all required parameters will require you to add a value
  let(:params) do
    {
      :allow_groups => '',
      :allow_tcp_forwarding => 'no',
      :allow_users => '',
      :ciphers => 'aes128-ctr,aes192-ctr,aes256-ctr',
      :client_alive_count_max => '0',
      :client_alive_interval => '300',
      :deny_groups => '',
      :deny_users => '',
      :hostbased_authentication => 'no',
      :ignore_rhosts => 'yes',
      :log_level => 'VERBOSE',
      :macs => 'hmac-sha1',
      :max_auth_tries => '4',
      :package_ensure => 'present',
      :package_name => 'openssh-server',
      :permit_empty_passwords => 'no',
      :permit_root_login => 'no',
      :permit_user_environment => 'no',
      :port => '22',
      :protocol => '2',
      :rhosts_rsa_authentication => 'no',
      :service_enable => 'true',
      :service_ensure => 'running',
      :ssh_banner => '/etc/motd',
      :sshd_config_template => 'ssh/sshd_config.erb',
      :x11_forwarding => 'no',
    }
  end
  # add these two lines in a single test block to enable puppet and hiera debug mode
  # Puppet::Util::Log.level = :debug
  # Puppet::Util::Log.newdestination(:console)
  it do
    is_expected.to contain_package('openssh-server').
             with({"ensure"=>"present",
                   "allow_virtual"=>"true"})
  end
  it do
    is_expected.to contain_file('/etc/ssh/sshd_config').
             with({"ensure"=>"file",
                   "owner"=>"root",
                   "group"=>"root",
                   "mode"=>"0644"})
  end
  it do
    is_expected.to contain_service('sshd').
             with({"ensure"=>"running",
                   "enable"=>"true"})
  end
end
