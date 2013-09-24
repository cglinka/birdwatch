require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/contrib'
require 'rest_client'
require_relative 'lib/birdwatch.rb'

get '/' do
    erb:index
end

get '/birdlist' do
  @lat_lng = cookies[:lat_lng].split("|")

  @loc = Chirp::Location.new(@lat_lng)
  @lat = @loc.lat
  @long =@loc.long
  @birds_json = @loc.get_list()
  @birds_json = @birds_json.map { |o| Hash[o.each_pair.to_a] }.to_json

  erb:birdlist
end
