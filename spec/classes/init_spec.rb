require 'spec_helper'
describe 'aide' do
  context 'with default values for all parameters' do
    it { should contain_class('aide') }
  end
end
