require 'spec_helper'
describe 'aide', type: 'class' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let (:facts) { facts }
      context 'with no parameters' do
        let (:params) {{}}
        it { is_expected.to compile.with_all_deps }
        it do
          is_expected.to contain_class('aide').
            with_package('aide').
            with_package_ensure('latest').
            with_hour(1).
            with_minute(0).
            with_email('root@localhost').
            with_db_dir('/var/lib/aide').
            with_log_dir('/var/log/aide')
        end
        it {is_expected.to contain_class('aide::install').that_comes_before('Class[aide::config]') }
        it {is_expected.to contain_class('aide::config').that_notifies('Class[aide::installdb]') }
        it {is_expected.to contain_class('aide::installdb').that_comes_before('Class[aide::cron]') }
        it {is_expected.to contain_class('aide::cron') }
        it {is_expected.to have_aide__rule_resource_count(0) }
      end
      context 'with all parameters' do
        let (:params) do 
          {:package         => 'aide2',
            :package_ensure => '2.1.7',
            :hour           => 17,
            :minute         => 21,
            :email          => 'foo@bar.baz',
            :db_dir         => '/var/x/aide',
            :log_dir        => '/var/log/x'}
        end
        it { is_expected.to compile.with_all_deps }
        it do
          is_expected.to contain_class('aide').
            with_package('aide2').
            with_package_ensure('2.1.7').
            with_hour(17).
            with_minute(21).
            with_email('foo@bar.baz').
            with_db_dir('/var/x/aide').
            with_log_dir('/var/log/x')
        end
        it { is_expected.to contain_file('/var/log/x') }
        it { is_expected.to contain_file('/var/x/aide/aide.db.gz') }
        it { is_expected.to contain_package('aide2') }
      end
    end
  end
end


