module TangerineGirl

  @@definitions = {}

  def self.create(template_name, overrides={})
    @@definitions[template_name].create(overrides)
  end

  def self.define(template_name)
    template = TangerineGirl::Template.new(template_name)
    yield template
    @@definitions[template_name] = template
  end

  class Template

    def initialize(name)
      @name = name
      @defaults = {}
    end

    def create(overrides)
      options = @defaults.dup.merge(overrides)
      subject = "Tangerine::#{@name.to_s.classify}".constantize
      subject.new(options)
    end

    def method_missing(method, *args, &block)
      if method.to_s =~ /=$/
        attr_name = method.to_s.gsub(/=$/, '').to_sym
        @defaults[attr_name] = *args
      else
        super(method, *args, &block)
      end
    end
  end

end

TangerineGirl.define(:channel_set) do |cs|
  cs.embed_code = "BLABLABLALBLABLABLBAHHH!!!!"
  cs.title = "an ode to channelsets"
  # cs.description = nil
  # cs.flight_start_time = "1294087113"
  # cs.height = "3"
  # cs.size = nil
  # cs.stat = nil
  # cs.status = "live"
  # cs.updated_at = "1294087113"
  # cs.uploaded_at = "1294087113"
  # cs.width = "4"
end

TangerineGirl.define(:channel) do |ch|
  ch.embed_code = 'lorem ipsum embed'
end

TangerineGirl.define(:video) do |v|
  v.embed_code = 'video embed code'
  v.title = ''
end
