require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tangerine::Player do
  authenticate!

  context 'delivering js path for a video' do

    describe '#render' do

      context 'when given only an embed code, width & height' do

        let(:embed_code) { 'test-embed-code' }
        let(:width) { '1000000000' }
        let(:height) { '1' }
        subject { Tangerine::Player.new(:embed_code => embed_code, :width => width, :height => height) }
        its(:render) { should == "http://player.ooyala.com/player.js?width=#{width}&height=#{height}&embedCode=#{embed_code}" }

      end
    end

  end

end
