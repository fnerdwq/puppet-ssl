require 'spec_helper'

describe 'ssl::self_signed_certificate' do
  let(:title) { 'testhost.example.de' }

  it { should contain_class('ssl::install') }

end
