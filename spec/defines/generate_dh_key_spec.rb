require 'spec_helper'

describe 'ssl::generate_dh_key' do
  let(:title) { 'testhost.example.de' }

  it { should contain_class('ssl::install') }

end
