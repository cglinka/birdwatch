require 'json'
require 'rest-client'
require 'pry'
require 'bundler/setup'
require 'geocoder'

module Chirp
  class Location
    attr_reader :lat, :long, :dist
    def initialize(lat, long, dist=5)
      @lat = lat.round(2)
      @long = long.round(2)
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