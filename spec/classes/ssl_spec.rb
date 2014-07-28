require 'spec_helper'

describe 'ssl' do
    let(:node) { 'testhost.example.de' }

    it { should contain_ssl__self_signed_certificate('testhost.example.de') }
end
