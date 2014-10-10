require 'spec_helper'

describe 'ssl::self_signed_certificate' do
  let(:title) { 'testhost.example.de' }
  let(:node)  { 'testhost.example.de' }

  # for omd/monitoring related tests we need to set the must parameter
  let(:pre_condition) { 'class omd::client { $check_mk_version = "1.2.3" }' }

  directory = "/etc/ssl"

  context "with default parameters" do
    it { is_expected.to contain_class('ssl::install') }
    it { is_expected.to contain_file(directory).with_ensure('directory') }
    it { is_expected.to contain_file("#{directory}/#{node}.cnf").with_content(/^CN = #{node}$/) }
  end

  context "parameter country => 'COM'" do
    let(:params) { { 'country' => 'COM' } }
    it { is_expected.to raise_error(Puppet::Error) }
  end

  context "parameter country => 'DE', organization => 'example'" do
    let(:params) { { 'country' => 'DE', 'organization' => 'example' } }
    it { is_expected.to contain_file("#{directory}/#{node}.cnf").with_content(/^C = DE$/) }
    it { is_expected.to contain_file("#{directory}/#{node}.cnf").with_content(/^O = example$/) }
  end

  describe 'with enabled monitoring' do
    context 'parameter check => true' do
      let(:params) {{ :check => true }}

      it do
        is_expected.to contain_omd__client__checks__cert('testhost.example.de')\
          .with_path("#{directory}/testhost.example.de.crt")\
          .that_requires("File[#{directory}/testhost.example.de.crt]")
      end
    end
    context 'parameter check => true + adjusted check parameters' do
      let(:params) {{
        :check      => true,
        :check_crit => '3600',
        :check_warn => '7200',
      }}

      it do
        is_expected.to contain_omd__client__checks__cert('testhost.example.de').with({
          :path => "#{directory}/testhost.example.de.crt",
          :crit => '3600',
          :warn => '7200',
        })
      end
    end
    context 'parameter check => breakme' do
      let(:params) {{ :check => 'breakme' }}
      it { is_expected.to raise_error(/not a boolean/) }
    end
  end

end
