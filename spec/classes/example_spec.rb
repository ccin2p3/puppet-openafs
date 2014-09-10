require 'spec_helper'

describe 'openafs' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "openafs class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('openafs::params') }
        it { should contain_class('openafs::install').that_comes_before('openafs::config') }
        it { should contain_class('openafs::config') }
        it { should contain_class('openafs::service').that_subscribes_to('openafs::config') }

        it { should contain_service('openafs') }
        it { should contain_package('openafs').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'openafs class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('openafs') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
