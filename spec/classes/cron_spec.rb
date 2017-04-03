require 'spec_helper'

describe 'aide::cron', type: 'class' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let (:facts) { facts }
      case facts[:osfamily]
      when 'Debian'
        let (:aide_path) {'/usr/bin/aide'}
        let (:conf_dir) {'/etc/aide'}
        let (:mail_path) {'/usr/bin/mail'}
      when 'RedHat'
        let (:aide_path) {'/usr/sbin/aide'}
        let (:conf_dir) {'/etc'}
        let (:mail_path) {'/bin/mail'}
      end
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('aide::cron') }
      it do 
        is_expected.to contain_cron('aide').
          with_command("#{conf_dir}/aide_check.sh").
          with_user('root').
          with_hour(1).
          with_minute(0)
      end
    end
  end
end
