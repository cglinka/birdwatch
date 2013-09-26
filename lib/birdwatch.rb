require 'json'
require 'rest_client'
require 'pry'
require 'bundler/setup'
require 'rubygems'
require 'flickraw'

module Chirp
  class Location
    attr_reader :lat, :long, :dist
    attr_accessor :template

    def initialize(lat_lng, dist=1)
      @lat = lat_lng[0].to_f.round(2)
      @long = lat_lng[1].to_f.round(2)
      @dist = dist
      @sci_name_list = []
    end

    # Get list of recently observed birds in JSON format from Cornell API.
    #
    # Return an Array of Hash objects containing the common and scientific
    # bird names.
    def get_list
      @url_str = mk_str
      call_cornell_api
      @list = JSON.parse(@list)
      template= []
      @list.each do |bird|
        @birdie ={"comName"=> bird["comName"], "sciName"=> bird["sciName"]}
        template << @birdie
      end
      template
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
    attr_reader :list, :sci_name_list, :pic_array
    # List is an Array of Hashes
    #
    # EX: [ {'comName' => 'Sparrow', 'sciName' => 'Sparrowus Thingify'},
    #       {'comName' => 'Common Name', 'sciName' => 'Scientific name'}]
    def initialize(list)
      @list = list
      @name_list = []
    end

    # Method to pull the scientific or common name into an array on it's own.
    # name must be either "sciName" or "comName"
    #
    # Returns an Array of Hashes
    # WORKS!!
    def name_list(name)
      @list.each do |bird|
        bird_name = bird[name]
        @name_list << bird_name
      end
      return @name_list
    end

    # Flickr search: take scientific name and search flickr
    #
    # Returns a Ruby Hash object.
    def flickr_call(name)

      # FlickRaw.api_key =ENV['API_KEY']
      # FlickRaw.shared_secret =ENV['SHARED_SECRET']
      FlickRaw.api_key ='92902020c21a89d6133eb748396c78cb'


      FlickRaw.shared_secret ='f15fc36f5e05e736'
      
      picture = flickr.photos.search(
        :text => name,
        :sort => 'interestingness-desc',
        :safe_search => 1,
        :format => 'json',
        :nojsoncallback => 1,
        :per_page => 1,
        :extras => 'url_q'
      )
      puts "flicker_call complete"
      return picture[0]
    end

    # Takes a Hash object as arguemnt and isolates the picture URL.
    #
    # Returns URL of most interesting image that is associated with text that matches the scientific name.
    def get_pic_url(name)
      picture = flickr_call(name)
      url = picture["url_q"]
      return url
    end

    # Puts the picture URL's into an array
    #
    # Takes the Array of scientific names and runs the Flickr image search
    #
    # Returns an Array of image URLs
    def picture_array
      @sci_name_list = name_list("sciName")
      @pic_array = []
      @sci_name_list.each do |bird|
        url = get_pic_url(bird)
        @pic_array << url
      end
      puts "The picture array is #{@pic_array.length} long."
      return @pic_array
    end

    # Combines the image URLs with the @list Array from birdmain.rb
    #
    def add_to_template
      @pic_urls = picture_array
      @list.each_with_index do |bird, index|
        url = @pic_urls[index]
        @list[index]["img_url"] = url
      end
      puts "The @list is #{list.length} long."
      return @list
    end 

    def add_wiki_to_template
      @info_list= info_array
      @list.each_with_index do |bird, index|
        info = @info_list[index]
        @list[index]["info"] = info
      end
      puts "The @list is #{list.length} long."
      return @list
    end 

    def info_array
      @com_name_list = name_list("comName")
      @info_array = []
      @com_name_list.each do |bird|
        info = get_wiki(bird)
        @info_array << info
      end
    end

    def get_wiki(name)
      extract = Wikipedia.find(name, :prop => "extracts").json
      extract = JSON.parse(extract)
      extract =extract["query"]
      markup = {}
      extract.each do |key, pages|
        pages.each do |key, num|
          num.each do |key, info|
            markup = info
          end
        end
      end
    end
  end
end