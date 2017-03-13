require 'spec_helper'
describe 'aide', type: 'class' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let (:facts) { facts }
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('aide') }
      it {is_expected.to contain_class('aide::install').that_comes_before('Class[aide::config]') }
      it {is_expected.to contain_class('aide::config').that_notifies('Class[aide::installdb]') }
      it {is_expected.to contain_class('aide::installdb').that_comes_before('Class[aide::cron]') }
      it {is_expected.to contain_class('aide::cron') }
      it {is_expected.to have_aide__rule_resource_count(0) }
    end
  end
end


