require_relative "../lib/birdwatch.rb"

describe Chirp::Location  do
  # let (:loc){Chirp::Location.new(-97.75000, 30.25000)}
  describe ".initialize" do
    context "When no distance is inputed" do
      it 'sets latitude, longitude, and distance of 5' do
      
        loc =Chirp::Location.new(-97.75000, 30.25000)
        expect(loc.lat).to eq(-97.75)
        expect(loc.long).to eq(30.25)
        expect(loc.dist).to eq(5)
      end
    end
    context "When distance is inputed" do
      it 'sets latitude, longitude and distance' do
        loc = Chirp::Location.new(-97.75000, 30.25000, 10)
        
        expect(loc.lat).to eq(-97.75)
        expect(loc.long).to eq(30.25)
        expect(loc.dist).to eq(10)
      end
    end
  end
end