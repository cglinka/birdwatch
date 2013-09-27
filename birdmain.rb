require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/contrib'
require 'rest_client'
require 'rest-client'
require 'flickraw'
require_relative 'lib/birdwatch.rb'

get '/' do
    erb:index
end

get '/birdlist' do
    #@lat_lng = cookies[:lat_lng].split("|")
    @lat_lng = [30.267153, -97.743061]
    @loc = Chirp::Location.new(@lat_lng)
    # Gets list of birds in JSON format from Cornnell, transforms into a Ruby object.
    @birds = @loc.get_list
    # Temp command to use only Cornell data to populate /birdlist
    # @birds_json = @birds.map { |o| Hash[o.each_pair.to_a] }.to_json


    # Takes list of bird names and feeds it into the Content class
    @content = Chirp::Content.new(@birds)
    # # Appends image URL's to each Hash object in the @content Array.
    #@content_array = @content.add_to_template
    # # Turn ruby object back into JSON.
    @content_array = [
    {
        "comName" => "Yellow-crowned Night-Heron",
        "sciName" => "Nyctanassa violacea",
        "img_src" => "http://farm3.staticflickr.com/2453/4034562092_66c80760dc.jpg"
    },
    {
        "comName" => "White-winged Dove",
        "sciName" => "Zenaida asiatica",
        "img_src" => "http://farm8.staticflickr.com/7091/7338226784_acb7f13611.jpg"
    },
    {
        "comName" => "Rock Pigeon",
        "sciName" => "Columba livia",
        "img_src" => "http://farm4.staticflickr.com/3023/2367694753_cb4a50b22f.jpg"
    }]
    @content_array = @content.add_wiki_to_template
    puts @content_array
    @birds_json = @content_array.map { |o| Hash[o.each_pair.to_a] }.to_json

    erb:birdlist
end