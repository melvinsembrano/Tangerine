class Tangerine::ChannelSet < Tangerine::Base

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

  finder do
    response = Tangerine.query('contentType' => 'MultiChannel')
    response.parsed_response['list']['item']
  end

  def as_json(options = {})
    {:channels => channels}
  end

  def to_json(options = {})
    {:channels => channels}.to_json
  end

  def channels
    result = Tangerine::Backlot::API.get('/channel_sets', 'mode' => 'list', 'channelSetEmbedCode' => embed_code)
    items = result.parsed_response['channelSet']['channel']
    items = Tangerine::Base.prepare_items(items)
    items.collect {|item| Tangerine::Channel.new(item) }
  end

end

