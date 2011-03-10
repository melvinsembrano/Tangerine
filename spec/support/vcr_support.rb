def pause_vcr(cassette_name=nil, erb=false)

  Timecop.freeze(Time.local(2012, 1, 1, 10, 0, 0))
  VCR.insert_cassette(cassette_name, :erb => erb)

end

def play_vcr
  VCR.eject_cassette
  Timecop.return
end
