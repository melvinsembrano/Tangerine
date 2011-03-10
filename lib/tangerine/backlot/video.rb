class Tangerine::Video
  def self.all
    Tangerine.query('contentType' => 'Video')
  end
end

