require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'rest-client'
require_relative 'lib/birdwatch.rb'

get '/' do 
    erb:index   
end

get '/birdlist' do
    @lat_lng = cookies[:lat_lng].split("|")
    @loc = Chirp::Location.new(@lat_lng)
    @url_str = @loc.mkstr
    list = RestClient.get(@url_str), {:accept => :json}
    erb:birdlist
end
