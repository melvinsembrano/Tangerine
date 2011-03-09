class Tangerine::Video
  def self.all
    Tangerine::Query.new('contentType' => 'Video').response
  end
end

