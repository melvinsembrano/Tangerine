require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tangerine::ChannelSet do
  authenticate!

  context 'retreiving a specific channelset' do

    describe '.find' do

      let(:title) { 'My Awesome Title' }
      let(:embed_code) { 'My Awesome Embed Code' }
      let(:mock_channel_set) { double(:embed_code => embed_code, :title => title) }
      let(:vcr_erb) { {:mock_channel_set => mock_channel_set} }

      # TODO: find a better way to build these up ala FactoryGirl sans ActiveRecord
      let(:channel_set) do
        Tangerine::ChannelSet.new(
          :embed_code => embed_code,
          :title => title,
          :description => nil,
          :flight_start_time => "1294087113",
          :height => "3",
          :size => nil,
          :stat => nil,
          :status => "live",
          :title => "My Awesome Title",
          :updated_at => "1294087113",
          :uploaded_at => "1294087113",
          :width => "4"
        )
      end

      subject { Tangerine::ChannelSet.find(embed_code) }
      before do
        pause_vcr "Tangerine::Query.new('contentType' => 'MultiChannel')", vcr_erb
      end
      after { play_vcr }
      it { should be_functionally_equivalent_to(channel_set) }

    end
  end
end

