class Tangerine::Video < Tangerine::Base

  attr_accessor :size,
    :title,
    :thumbnail,
    :content,
    :updated_at,
    :embed_code,
    :description,
    :length,
    :status,
    :uploaded_at,
    :flight_start_time,
    :width,
    :height,
    :labels,
    :metadata,
    :stat

  finder do
    Tangerine.query('contentType' => 'Video').parsed_response['list']['item']
  end

  # def self.all
    # Tangerine.query('contentType' => 'Video')
  # end

  def initialize(options={})
    @options = options
    add_metadata
    add_labels

    options.delete('metadata')
    options.delete('labels')
    super(options)
  end

  def player(options={})
    options.merge!(:embed_code => embed_code, :width => width, :height => height)
    Tangerine::Player.new(options)
  end

  def self.where(options)
    # FYI
    # Adding 'status' => 'live' to the query string does not work!
    embed_codes = options[:embed_code].join(',')
    result      = Tangerine.query('embedCode' => embed_codes, 'fields' => 'labels,metadata')
    items       = result.parsed_response['list']['item']
    items       = Tangerine::Base.prepare_items(items)
    videos      = items.collect { |item| Tangerine::Video.new(item) }
    videos      = videos.reject { |video| video.status != 'live' }

    Tangerine::Video.order_videos!(videos, options[:embed_code])
  end
  
  def self.order_videos!(videos, embed_codes)
    ordered = []
    embed_codes.each do |code|
      ordered << videos.select { |video| video.embed_code == code }
    end
    ordered.flatten
  end

  def as_json(options = {})
    {:size => size,
     :title => title,
     :thumbnail => thumbnail,
     :content => content,
     :updated_at => updated_at,
     :embed_code => embed_code,
     :description => description,
     :length => length,
     :status => status,
     :uploaded_at => uploaded_at,
     :flight_start_time => flight_start_time,
     :width => width,
     :height => height,
     :labels => labels,
     :metadata => metadata,
     :stat => stat
    }
  end

  protected

  def add_labels
    return unless @options['labels']
    self.labels = Tangerine::Base.prepare_items(@options['labels']['label'])
  end

  def add_metadata
    return unless @options['metadata']

    self.metadata = {}
    meta_data = @options['metadata']['metadataItem']
    items = Tangerine::Base.prepare_items(meta_data)
    items.each do |meta_item|
      self.metadata[meta_item['name'].to_sym] = meta_item['value']
    end
  end
end

