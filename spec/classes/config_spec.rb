require 'spec_helper'
describe 'aide::config', type: 'class' do
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
      it { is_expected.to contain_class('aide::config') }
      it { is_expected.to contain_class('aide') }
      it do 
        is_expected.to contain_file("#{conf_dir}/aide.conf").
          with_path("#{conf_dir}/aide.conf").
          with_owner('root').
          with_group('root').
          with_mode('0600').
          with_replace('false').
          with_content(/database=file: \/var\/lib\/aide\/aide\.db\.gz/)
      end
      it do
        is_expected.to contain_file("#{conf_dir}/aide_check.sh").
          with_ensure('file').
          with_owner('root').
          with_group('root').
          with_mode('0500').
          with_content(/#{aide_path} \-\-check/).
          with_content(/root@localhost/)
      end
      it do
        is_expected.to contain_file('/var/log/aide').
          with_ensure('directory').
          with_path('/var/log/aide').
          with_recurse(false).
          with_purge(false).
          with_owner('root').
          with_group('root').
          with_mode('0700')
      end
    end
  end
end


