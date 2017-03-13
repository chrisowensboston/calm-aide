require 'spec_helper'

describe 'aide::cron', type: 'class' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let (:facts) { facts }
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('aide::cron') }
    end
  end
end
