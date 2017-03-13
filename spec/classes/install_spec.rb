require 'spec_helper'
describe 'aide::install', type: 'class' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let (:facts) { facts }
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('aide::install') }
      it { is_expected.to contain_class('aide') }
      it do 
        is_expected.to contain_package('aide').
          with({
                 'ensure' => 'latest',
                 'name'   => 'aide',
                 'alias'  => 'aide',
               })
      end
    end
  end
end


