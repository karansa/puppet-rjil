require 'spec_helper'
require 'hiera-puppet-helper'

describe 'rjil::contrail::server' do
  let :facts do
    {
      :operatingsystem => 'Debian',
      :osfamily        => 'Debian',
      :ipaddress_eth0  => '10.1.1.1',
      :interfaces      => 'eth0,lo',
      :lsbdistid        => 'ubuntu',
      :lsbdistcodename  => 'trusty',
    }
  end
  let :hiera_data do
    {
      'contrail::keystone_address'        => 'keystone_public_address',
      'contrail::keystone_admin_token'    => 'admin_token',
      'contrail::keystone_admin_password' => 'admin_pass',
      'contrail::keystone_auth_password'  => 'auth_pass',
    }
  end

  context 'with defaults' do
    it do
      should contain_file('/usr/lib/jiocloud/tests/ifmap.sh')
      should contain_file('/usr/lib/jiocloud/tests/contrail-analytics.sh')
      should contain_file('/usr/lib/jiocloud/tests/contrail-api.sh')
      should contain_file('/usr/lib/jiocloud/tests/contrail-control.sh')
      should contain_file('/usr/lib/jiocloud/tests/contrail-discovery.sh')
      should contain_file('/usr/lib/jiocloud/tests/contrail-dns.sh')
      should contain_file('/usr/lib/jiocloud/tests/contrail-schema.sh')
      should contain_file('/usr/lib/jiocloud/tests/contrail-webui-webserver.sh')
      should contain_file('/usr/lib/jiocloud/tests/contrail-webui-jobserver.sh')
      should contain_class('contrail')
      ['contrail-analytic-api','contrail-collector','query-engine','api','discovery','schema','svc-monitor','contrail-control','webserver','jobserver']. each do |x|
        should contain_rjil__jiocloud__logrotate(x).with_logdir('/var/log/contrail')
      end
    end
  end
end
