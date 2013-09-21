require 'json'
require 'rest-client'
require 'pry'
require 'bundler/setup'
require 'geocoder'

module Chirp
  class Location
    attr_reader :lat, :long, :dist
    def initialize(lat_lng, dist=5)
      @lat = lat_lng[0].round(2)
      @long = lat_lng[1].round(2)
      @dist = dist
    end

    def mk_str
      

    end
  end
end

# response = RestClient.get('http://ebird.org/ws1.1/data/obs/geo/recent?lng=-97.75&lat=30.25&fmt=json&dist=1', 
#   {:accept => :json})

# puts response
# puts response.code
# puts response.class