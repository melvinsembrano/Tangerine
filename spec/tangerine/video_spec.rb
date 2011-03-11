require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tangerine::Video do
  authenticate!

  context 'class methods' do
    subject { Tangerine::Video }
    let(:embed_codes) { ['I3MHB2MTqP5zvA8dYvzbvGlPJdg7DxRK','Z3Y3l3MTqHOLU6LMeTNbP2O91Oq5ADxm'] }

    let(:title1) { 'snowboarding' }
    let(:title2) { 'batmitten' }
    let(:vcr_erb) { {:title1 => title1, :title2 => title2} }
    before do
      pause_vcr "Tangerine.query('embedCode' => [embed_codes])", vcr_erb
    end
    after { play_vcr }


    describe '.all' do

      let(:mock_response) { mock }
      let(:params) { {'contentType' => 'Video'} }
      subject { Tangerine::Video.all }
      before { Tangerine.should_receive(:query).with(params).and_return(mock_response) }

      it 'returns the response of the query' do
        subject.should == mock_response
      end

    end

    describe '.where' do

      subject { Tangerine::Video }

      it 'returns the appropriate videos' do
        videos = subject.where(:embed_code => embed_codes)
        videos.length.should == 2
        videos.first.title.should == title1
        videos[1].title.should == title2
      end
    end

    describe '.new' do

      let(:options) do
        {"flightStartTime"=>"1291860167",
         "size"=>"146499024",
         "title"=>"snowboarding",
         "updatedAt"=>"1294868672",
         "thumbnail"=>"http://cdn.videos.thenorthface.com/I3MHB2MTqP5zvA8dYvzbvGlPJdg7DxRK/M_-lZjo5g2zgfr_H5hMDoxOjA0O88asB",
         "metadata"=> {
          "metadataItem"=>[{"name"=>"subtitle", "value"=>"Athlete"},
                           {"name"=>"bigmeta", "value"=>"BigMeta!"}]},
         "height"=>"720",
         "embedCode"=>"I3MHB2MTqP5zvA8dYvzbvGlPJdg7DxRK",
         "description"=>"TNF New Team Bio",
         "length"=>"218968",
         "status"=>"live",
         "labels"=>{"label"=>"/YouTube"},
         "stat"=>nil,
         "uploadedAt"=>"1291860167",
         "width"=>"1280"}
      end

      subject { Tangerine::Video.new(options) }
      it 'sets metadata on Video' do
        subject.metadata.should == {:subtitle => 'Athlete', :bigmeta => 'BigMeta!'}
      end

      it 'sets labels on Video' do
        subject.labels.should == ['/YouTube']
      end

    end
  end

end

