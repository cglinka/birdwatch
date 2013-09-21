require 'json'
require 'rest-client'
require 'pry'
require 'bundler/setup'


module Chirp
  class Location
    attr_reader :lat, :long, :dist
    def initialize(lat_lng, dist=5)
      @long = lat_lng[0].round(2)
      @lat = lat_lng[1].round(2)
      @dist = dist
    end

    def get_list
     @url_str = mk_str
     puts @url_str
      birds_json = RestClient.get(@url_str, {:accept => :json})
      puts birds_json
      birds_json = JSON.parse(birds_json)
    end

    def mk_str
      str = "http://ebird.org/ws1.1/data/obs/geo/recent?lng=#{@long}&lat=#{@lat}&dist=#{@dist}&fmt=json"
    end
  end


  # class Picture
  #   def initialize(list)
  #     @names = []
  #     list.each do |x|


  #   end

end