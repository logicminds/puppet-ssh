require 'spec_helper'
require 'shared_contexts'

describe 'ssh::ssh_keys' do
  # by default the hiera integration uses hiera data from the shared_contexts.rb file
  # but basically to mock hiera you first need to add a key/value pair
  # to the specific context in the spec/shared_contexts.rb file
  # Note: you can only use a single hiera context per describe/context block
  # rspec-puppet does not allow you to swap out hiera data on a per test block
  #include_context :hiera

  let(:title) { 'XXreplace_meXX' }
  
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
      :system_key_user => 'user1',
      #:key_password => "password",
      :system_user_home_dir => '/home/user1',
      #:ssh_rsa_public_key => 'place_value_here',
      #:ssh_rsa_private_key => undef,
    }
  end
  # add these two lines in a single test block to enable puppet and hiera debug mode
  # Puppet::Util::Log.level = :debug
  # Puppet::Util::Log.newdestination(:console)
  describe 'generate key' do
    describe 'without password' do
      let(:params) do
        {
          :system_key_user => 'user1',
          #:key_password => "password",
          :system_user_home_dir => '/home/user1',
        }
      end
      it do
        is_expected.to contain_exec('generate_key')
             .with(
               'command' => "cat /dev/zero | ssh-keygen -t rsa -b 2048 -q -N ''",
               'creates' => '/home/user1/.ssh/id_rsa',
               'require' => 'File[/home/user1]',
               'user'    => 'user1'
             )
      end
    end

    describe 'with password' do
      let(:params) do
        {
          :system_key_user => 'user1',
          :key_password => "password",
          :system_user_home_dir => '/home/user1',
        }
      end
      it do
        is_expected.to contain_exec('generate_key')
             .with(
               'command' => "cat /dev/zero | ssh-keygen -t rsa -b 2048 -q -N 'password'",
               'creates' => '/home/user1/.ssh/id_rsa',
               'require' => 'File[/home/user1]',
               'user'    => 'user1'
             )
      end
    end
  end

  describe 'provide key' do
    let(:params) do
      {
        :system_key_user => 'user1',
        #:key_password => "password",
        :system_user_home_dir => '/home/user1',
        :ssh_rsa_public_key => 'public_key',
        :ssh_rsa_private_key => 'private_key',
      }
    end
    it {is_expected.to_not contain_exec('generate_key')}
    it {is_expected.to contain_file("/home/user1/.ssh").with_ensure('directory')}
    it do
      is_expected.to contain_file("/home/user1/.ssh/id_rsa")
        .with(
           :ensure => 'file',
           :content => 'private_key',
           :mode => '0600',
           :owner => 'user1',
           :group => 'user1'
        )
    end
    it do
      is_expected.to contain_file("/home/user1/.ssh/id_rsa.pub")
         .with(
           :ensure => 'file',
           :content => 'public_key',
           :mode => '0644',
           :owner => 'user1',
           :group => 'user1'
         )
    end
  end
end
