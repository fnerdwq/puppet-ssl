require 'spec_helper'

describe 'ssl::self_signed_certificate' do
  let(:title) { 'testhost.example.de' }
  let(:node)  { 'testhost.example.de' }


  context "with default parameters" do

    directory = "/etc/ssl"

    it { should contain_class('ssl::install') }

    it { should contain_file(directory).with_ensure('directory') }

    it { should contain_file("#{directory}/#{node}.cnf").with(
        'content' => /^CN = #{node}$/
      )
    }

  end

end
