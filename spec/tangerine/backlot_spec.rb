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

      describe '.get' do

        let(:response) { mock }
        let(:request) { '/some-request-path' }

        it 'returns the HTTP response' do
          Tangerine::Backlot::HTTP.should_receive(:get).with(request).and_return(response)
          subject.get(request).should == response
        end

      end

    end
  end

end

