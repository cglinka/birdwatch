require 'json'
require 'rest-client'
require 'pry'
require 'bundler/setup'
require 'rubygems'


module Chirp
  class Location
    attr_reader :lat, :long, :dist 
    def initialize(lat_lng, dist=5)
      @lat = lat_lng[0].to_f.round(2)
      @long = lat_lng[1].to_f.round(2)
      @dist = dist
    end
    def get_list
      @url_str = mk_str
      @list = RestClient.get(@url_str, {:accept => :json})
      @list = JSON.parse(@list)
      template= []
      @list.each do |bird|
        @birdie ={"comName"=> bird["comName"], "sciName"=> bird["sciName"]}
        template << @birdie
      end
      template
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