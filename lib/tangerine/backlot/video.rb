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
    # <metadataItem name="director" value="Francis Ford Coppola"/>
    # <metadataItem name="actor" value="Marlon Brando"/>
  # <thumbnail height="79" width="106">
  :stat
    # <lifetime>
      # <displays total="0"/>
      # <plays total="0"/>
      # <rewinds total="0"/>
      # <playtime ms="0"/>
      # <watched _25="0" _50="0" _75="0" _100="0"/>
    # </lifetime>

  def self.all
    Tangerine.query('contentType' => 'Video')
  end

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
    embed_codes = options[:embed_code].join(',')
    result = Tangerine.query('embedCode' => embed_codes, 'fields' => 'labels,metadata')
    items = result.parsed_response['list']['item']
    items = Tangerine::Base.prepare_items(items)
    items.collect { |item| Tangerine::Video.new(item) }
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

