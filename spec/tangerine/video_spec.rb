require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tangerine::Video do
  authenticate!

  context 'class methods' do
    subject { Tangerine::Video }

    describe '.all' do

      let(:mock_response) { mock }
      let(:params) { {'contentType' => 'Video'} }
      subject { Tangerine::Video.all }
      before { Tangerine.should_receive(:query).with(params).and_return(mock_response) }

      it 'returns the response of the query' do
        subject.should == mock_response
      end

    end
  end

end

