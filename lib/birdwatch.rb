require 'json'
require 'rest-client'
require 'pry'
require 'bundler/setup'
require 'rubygems'
require 'flickraw'


module Chirp
  class Location
    attr_reader :lat, :long, :dist
    attr_accessor :template

    def initialize(lat_lng, dist=5)
      @long = lat_lng[0].round(2)
      @lat = lat_lng[1].round(2)
      @dist = dist
    end

    # Get list of recently observed birds in JSON format from Cornell API.
    #
    # Return an Array of Hash objects containing the common and scientific 
    # bird names.
    def get_list
      @url_str = mk_str
      call_cornell_api
      @list = JSON.parse(@list)
      @template= []
      @list.each do |bird|
        @birdie ={"comName"=> bird["comName"], "sciName"=> bird["sciName"]}
        @template << @birdie
      end
      @template
    end

    # Make the cornell api URL string from the initialized location.
    def mk_str
      str = "http://ebird.org/ws1.1/data/obs/geo/recent?lng=#{@long}&lat=#{@lat}&dist=#{@dist}&fmt=json"
    end

    # Call cornell api with URL from mk_str, store returning json object in 
    # @list.
    def call_cornell_api
      @list = RestClient.get(@url_str, {:accept => :json})
    end
  end

  class Content
    # List is an Array of Hashes
    #
    # EX: [ {'comName' => 'Sparrow', 'sciName' => 'Sparrowus Thingify'}, 
    #       {'comName' => 'Common Name', 'sciName' => 'Scientific name'}]
    def initialize(list)
      @list = list
    end

    # Method to pull the scientific name into an array on it's own.
    #
    # Returns an Array of Hashes
    def scientific_name_list
      @list.each do |bird|
        sci_name = bird["sciName"]
        @sci_name_list << sci_name
      end
      return @sci_name_list
    end

    # Flickr search: take scientific name and search flickr
    #
    # Returns URL of most interesting image that is associated with text that matches the scientific name.
    def get_picture(name)
      FlickRaw.api_key = ENV['API_KEY']
      FlickRaw.shared_secret = ENV['SHARED_SECRET']

      picture = flickr.photos.search(
        :text => name,
        :sort => 'interestingness-desc',
        :safe_search => 1,
        :format => 'json',
        :nojsoncallback => 1,
        :per_page => 1,
        :extras => 'url_q'
      )

      jpic = JSON.parse(picture)
      url = jpic["photos"]["photo"][0]["url_q"]
      return url
    end

    # Puts the picture URL's into an array
    #
    # Takes the Array of scientific names and runs the Flickr image search
    #
    # Returns an Array of image URLs
    def picture_array
      @sci_name_list = scientific_name_list
      @sci_name_list.each do |bird|
        get_picture(bird)
        @pic_array << url
      end
      return @pic_array
    end

    # Combines the image URLs with the @list Array from birdmain.rb
    #
    def add_to_template
      @pic_urls = picture_array
      @list.each_with_index do |bird, index|
        bird = { 'img_url' => pic_urls[index] }
      end
      return @list
    end
  end
end