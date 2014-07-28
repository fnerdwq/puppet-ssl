require 'spec_helper'

describe 'ssl' do
    let(:node) { 'testhost.example.de' }

    it { should contain_ssl__self_signed_certificate('testhost.example.de') }



    context 'node with long FQDN "test.example.co.uk"' do
      let(:node) { 'test.example.co.uk' }

      it {
        should contain_file("/tmp/#{node}.cnf").with_content(/^O =  example$/)
      }
    end
    context 'node with three letter TLD "test.example.com"' do
      let(:node) { 'test.example.com' }

      it {
        should contain_file("/tmp/#{node}.cnf").with_content(/^C = US$/)
      }
    end
end
