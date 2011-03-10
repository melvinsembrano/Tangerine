class Tangerine::ChannelSet

  attr_accessor :embed_code,
                :title,
                :description,
                :status,
                :uploaded_at,
                :size,
                :updated_at,
                :flight_start_time,
                :width,
                :height,
                :stat

  def initialize(options)
    options.delete('content_type')
    options.each do |k,v|
      # TODO: Look into using Crack gem for reliably undercoring these
      attr = k.to_s.underscore
      self.send("#{attr}=", v)
      # TODO: move into Base class
    end
  end

  def self.find(embed_code)
    result = Tangerine::Query.new('contentType' => 'MultiChannel')
    meh = result.response.parsed_response['list']['item'].first
    Tangerine::ChannelSet.new(meh)
  end
end
