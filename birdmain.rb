require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require_relative 'lib/birdwatch.rb'

get '/' do 
    erb:index   
end

get '/birdlist'
    erb:birdlist
end
