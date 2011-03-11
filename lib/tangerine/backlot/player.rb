class Tangerine::Player < Tangerine::Base
  attr_accessor :width,
    :height,
    :embed_code,
    :browser_placement,
    :hide,
    :autoplay

  def render
    "http://player.ooyala.com/player.js?width=#{width}&height=#{height}&embedCode=#{embed_code}"
  end
end
