require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tangerine::ChannelSet do
  authenticate!

  let(:embed_code) { 'My Awesome Embed Code' }
  let(:title) { 'My Awesome Title' }
  let(:mock_channel_set) { double(:embed_code => embed_code, :title => title) }
  let(:vcr_erb) { {:channel_sets => channel_sets} }
  let(:channel_set) { TangerineGirl.create(:channel_set, :embed_code => embed_code, :title => title) }
  let(:channel_sets) do
    channel_sets = []
    5.times { channel_sets << TangerineGirl.create(:channel_set) }
    channel_sets << channel_set
    channel_sets
  end

  context 'retreiving channelsets' do

    before do
      pause_vcr "query/channel_sets", vcr_erb
    end
    after { play_vcr }

    describe '.all' do
      it 'returns an array of ChannelSet objects' do
        Tangerine::ChannelSet.all.map(&:embed_code).should == channel_sets.map(&:embed_code)
      end
    end

    describe '.find' do

      subject { Tangerine::ChannelSet.find(embed_code) }
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

