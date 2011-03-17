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

  finder do
    Tangerine.query('contentType' => 'Channel').parsed_response['list']['item']
  end

  def videos
    channel = Tangerine::Backlot::API.get('/channels', 'mode' => 'list', 'channelEmbedCode' => embed_code)
    items = channel.parsed_response['channel']['item']
    items = Tangerine::Base.prepare_items(items)
    embed_codes = items.collect { |item| item['embedCode'] }
    Tangerine::Video.where(:embed_code => embed_codes)
  end

  def as_json(options = {})
    # TODO: Figure out why rails needs this to be called so badly
    vids = videos

    {:size => size,
     :title => title,
     :thumbnail => thumbnail,
     :updated_at => updated_at,
     :embed_code => embed_code,
     :description => description,
     :length => length,
     :status => status,
     :uploaded_at => uploaded_at,
     :videos => vids
    }
  end
end
