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
    @lat_lng = cookies[:lat_lng].split("|")
    @loc = Chirp::Location.new(@lat_lng)
    # Gets list of birds in JSON format from Cornnell, transforms into a Ruby object.
    @birds = @loc.get_list
    pp @birds
    # Temp command to use only Cornell data to populate /birdlist
    # @birds_json = @birds.map { |o| Hash[o.each_pair.to_a] }.to_json


    # Takes list of bird names and feeds it into the Content class
    @content = Chirp::Content.new(@birds)
    # # Appends image URL's to each Hash object in the @content Array.
    @content = @content.add_to_template
    # # Turn ruby object back into JSON.
    @birds_json = @content.map { |o| Hash[o.each_pair.to_a] }.to_json

    erb:birdlist
end
