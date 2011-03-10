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

        context 'when making subsequent requests' do

          let(:original_params) { { 'contentType' => 'Channel' } }
          before do
            Tangerine::Backlot::HTTP.stub(:get)
            Tangerine::Backlot::API.get('/query', original_params)
          end
          subject { Tangerine::Backlot::HTTP }

          it 'clears parameters before the new request' do
            Tangerine::Backlot::API.get('/channel_sets', 'mode' => 'list')
            subject.default_params.keys.should_not include('contentType')
          end
        end

      end

    end
  end

end

