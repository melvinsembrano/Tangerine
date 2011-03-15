Factory.define :channel_set, :class => Tangerine::ChannelSet do |cs|
  cs.embed_code  "BLABLABLALBLABLABLBAHHH!!!!"
  cs.title  "an ode to channelsets"
  cs.description  nil
  cs.flight_start_time  "1294087113"
  cs.height  "3"
  cs.size  nil
  cs.stat  nil
  cs.status  "live"
  cs.updated_at  "1294087113"
  cs.uploaded_at  "1294087113"
  cs.width  "4"
end

Factory.define :channel, :class => Tangerine::Channel do |ch|
  ch.embed_code 'lorem ipsum embed'
end

Factory.define :video, :class => Tangerine::Video do |v|
  v.embed_code 'video embed code'
  v.title ''
end
