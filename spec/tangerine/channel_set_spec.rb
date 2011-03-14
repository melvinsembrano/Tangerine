require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tangerine::ChannelSet do
  authenticate!

  let(:embed_code) { 'My Awesome Embed Code' }
  let(:title) { 'My Awesome Title' }
  let(:mock_channel_set) { double(:embed_code => embed_code, :title => title) }
  let(:vcr_erb) { {:mock_channel_set => mock_channel_set} }
  let(:channel_set) do
    TangerineGirl.create(:channel_set, :embed_code => embed_code, :title => title)
  end

  context 'retreiving a specific channelset' do

    describe '.find' do

      subject { Tangerine::ChannelSet.find(embed_code) }
      before do
        pause_vcr "query/channel_sets", vcr_erb
      end

      after { play_vcr }
      # it { should be_functionally_equivalent_to(channel_set) }
      its(:embed_code) { should == embed_code }
      its(:title) { should == title }

    end
  end

  context 'retreiving its channels' do
    describe '#channels' do

      let(:embed_code) { '85aTdiMjoYR5K26Fp8TMgGtGQUCEC2Y1' }
      let(:title) { 'Snowboarding' }
      let(:vcr_erb) { {:title => title} }

      before do
        Tangerine::ChannelSet.stub(:find).with(embed_code).and_return(channel_set)
        pause_vcr "channel_sets/show", vcr_erb
      end
      after { play_vcr }
      subject { Tangerine::ChannelSet.find(embed_code) }

      it 'returns a list of channels belonging to the channelset' do
        subject.channels.first.title.should == title
      end

    end
  end

end

