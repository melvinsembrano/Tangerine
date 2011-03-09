require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tangerine::Backlot do
  authenticate!

  describe Tangerine::Backlot::HTTP do
    subject { Tangerine::Backlot::HTTP }
    its(:base_uri) { should == 'http://api.ooyala.com/partner' }
  end

  describe Tangerine::Backlot::API do
    context 'class methods' do
      subject { Tangerine::Backlot::API }
      let(:params) { {'some_key' => 'some_value'} }

      # it { puts subject.get('/query', 'contentType' => 'MultiChannel').inspect }
      describe '.get' do
        let(:response) { mock }
        let(:request) { '/some-request-path' }
        before { Tangerine::Backlot::HTTP.should_receive(:get).with(request).and_return(response) }

        it 'returns the HTTP response' do
          subject.get(request, params).should == response
        end
      end

    end
  end

end

