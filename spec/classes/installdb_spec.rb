require 'spec_helper'
describe 'aide::installdb', type: 'class' do
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
      it { is_expected.to contain_class('aide::installdb') }
      it { is_expected.to contain_class('aide') }
      it do 
        is_expected.to contain_exec('aide_init').
          with({
                 'command'     => "#{aide_path} --init --config #{conf_dir}/aide.conf",
                 'user'        => 'root',
                 'refreshonly' => true,
               })
      end
      it do
        is_expected.to contain_file('/var/lib/aide/aide.db.gz').
          with_ensure('file').
          with_backup('.bak').
          with_owner('root').
          with_group('root').
          with_mode('0400').
          with_source('file:/var/lib/aide/aide.db.new.gz').
          that_subscribes_to('Exec[aide_init]')
      end
    end
  end
end


