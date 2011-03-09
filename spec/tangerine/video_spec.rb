require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tangerine::Video do
  authenticate!

  context 'class methods' do
    subject { Tangerine::Video }

    describe '.all' do

      let(:mock_response) { mock }
      let(:query_double) { double(:response => mock_response) }
      let(:params) { {'contentType' => 'Video'} }
      subject { Tangerine::Video.all }
      before { Tangerine::Query.should_receive(:new).with(params).and_return(query_double) }

      it 'returns the response of the query' do
        subject.should == mock_response
      end

    end
  end

end

