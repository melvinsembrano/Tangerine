require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tangerine::Channel do
  authenticate!

  context 'retrieving videos associated with a channel' do

    describe '#videos' do
      let(:channel_set) do
        TangerineGirl.create(:channel_set)
      end

      let(:channel) do
        TangerineGirl.create(:channel, :embed_code => '9haTdiMjoVHPey7H15JCroS9tJ25Xzw2')
      end

      let(:videos) do
        [
          TangerineGirl.create(:video, :embed_code => embed_codes.first, :title => title),
          TangerineGirl.create(:video, :embed_code => embed_codes[1])
        ]
      end

      let(:embed_codes) { ['I3MHB2MTqP5zvA8dYvzbvGlPJdg7DxRK','Z3Y3l3MTqHOLU6LMeTNbP2O91Oq5ADxm'] }
      let(:title) { 'Awesomest Skiiing video' }
      let(:vcr_erb) { {:title => title} }

      before do
        Tangerine::Video.stub(:where).with(:embed_code => embed_codes).and_return(videos)
        # Tangerine.stub(:query).with('embedCode' => embed_codes.join(',')).and_return(videos)
        channel_set.stub(:channels).and_return([channel])
        pause_vcr "channels/list", vcr_erb
      end
      after { play_vcr }
      subject { channel }

      it 'returns a list of videos belonging to the channel' do
        subject.videos.first.title.should == title
      end
    end
  end

end

# channel_set = Tangerine::ChannelSet.find(blah)
# first_channel = channel_set.channels.first
# videos = first_channel.videos

