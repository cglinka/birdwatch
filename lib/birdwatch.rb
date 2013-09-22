require 'json'
require 'rest-client'
require 'pry'
require 'bundler/setup'
require 'rubygems'
require 'flickraw'


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


  class Picture
    # List is an Array of Hashes
    #
    # EX: [ {'comName' => 'Sparrow', 'sciName' => 'Sparrowus Thingify'}, {'comName' => 'Common Name',
    # 'sciName' => 'Scientific name'}]
    def initialize(list)
      @list = list
    end

    # Method to pull the scientific name into an array on it's own.
    #
    # Returns an Array of Hashes
    def scientific_name_list
      @list.each do |bird|
        @sci_name_list << bird["sciName"]
      end
    end

    def get_picture(name)
      FlickRaw.api_key = ENV['API_KEY']
      FlickRaw.shared_secret = ENV['SHARED_SECRET']

      picture = flickr.photos.search {
        :text => name,
        :sort => interestingness-desc,
        :safe_search => 1,
        :format => json,
        :nojsoncallback => 1,
        :per_page => 1
      }

      jpic = JSON.parse(picture)

      info = flickr.photos.getInfo(:photo_id => a)
      url = FlickRaw.url_b(info)
      return url
    end

    def picture_array
      @sci_name_list.each do |bird|
        get_picture(bird)
        @pic_array << url
      end
    end

    def add_to_template
      
    end

end