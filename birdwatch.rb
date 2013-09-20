require 'json'
require 'rest-client'

response = RestClient.get('http://ebird.org/ws1.1/data/obs/geo/recent?lng=-97.75&lat=30.25&fmt=json&dist=1', 
  {:accept => :json})

puts response
puts response.code
puts response.class