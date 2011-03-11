class Tangerine::Channel < Tangerine::Base

  attr_accessor :size,
    :title,
    :thumbnail,
    :updated_at,
    :embed_code,
    :description,
    :length,
    :status,
    :uploaded_at

  def videos
    channel = Tangerine::Backlot::API.get('/channels', 'mode' => 'list', 'channelEmbedCode' => embed_code)
    items = channel.parsed_response['channel']['item']
    items = Tangerine::Base.prepare_items(items)
    embed_codes = items.collect { |item| item['embedCode'] }
    Tangerine::Video.where(:embed_code => embed_codes)
  end
end
