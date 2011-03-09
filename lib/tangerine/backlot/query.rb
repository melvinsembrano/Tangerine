class Tangerine::Query
  attr_reader :response

  def initialize(options)
    @response = Tangerine::Backlot::API.get('/query', options)
  end

end

