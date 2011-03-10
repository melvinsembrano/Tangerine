class Tangerine::Base

  def initialize(options)
    options.delete('content_type')
    options.each do |k,v|
      # TODO: Look into using Crack gem for reliably undercoring these
      attr = k.to_s.underscore
      self.send("#{attr}=", v)
    end
  end

  def self.prepare_items(items)
    # Yes, we are fully aware that type-checking sucks. Move along now, nothing to see here.
    items.is_a?(Array) ? items : [items]
  end

  def self.finder(&block)
    @finder = block
  end

  def self.find(embed_code)
    results = @finder.call
    results = self.prepare_items(results)
    found_item = results.select { |item| item['embedCode'] == embed_code }.first
  end

end
