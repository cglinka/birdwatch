require 'json'
require 'rest-client'
require 'pry'
require 'bundler/setup'
require 'geocoder'

module Chirp
  class Location
    attr_reader :lat, :long, :dist
    def initialize(lat_lng, dist=5)
      @long = lat_lng[0].round(2)
      @lat = lat_lng[1].round(2)
      @dist = dist
    end

    def mk_str
      str = "http://ebird.org/ws1.1/data/obs/geo/recent?lng=#{@long}&lat=#{@lat}&dist=#{@dist}&fmt=json"
    end
  end
end