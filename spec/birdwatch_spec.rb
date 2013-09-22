require_relative "../lib/birdwatch.rb"

describe Chirp::Location  do
  let (:loc){Chirp::Location.new([-97.75000, 30.25000])}
  let (:locdist){Chirp::Location.new([-97.75000, 30.25000], 10)}

  describe ".initialize" do
    context "When no distance is inputed" do
      it 'sets latitude, longitude, and distance of 5' do
        expect(loc.lat).to eq(30.25)
        expect(loc.long).to eq(-97.75)
        expect(loc.dist).to eq(5)
      end
    end

    context "When distance is inputed" do
      it 'sets latitude, longitude and distance' do

        expect(locdist.lat).to eq(30.25)
        expect(locdist.long).to eq(-97.75)
        expect(locdist.dist).to eq(10)
      end
    end
  end

  describe "#mk_str" do
    it "concatenates a string based on initialize" do

      expect(loc.mk_str).to eq("http://ebird.org/ws1.1/data/obs/geo/recent?lng=-97.75&lat=30.25&dist=5&fmt=json")
      expect(locdist.mk_str).to eq("http://ebird.org/ws1.1/data/obs/geo/recent?lng=-97.75&lat=30.25&dist=10&fmt=json")
    end
  end

  describe "#get_loc" do
    it "returns an array of objects " do
      list=double("list")

      allow(list).to receive(:jsonlist).and_return([
        {"comName"=>"Baltimore Oriole", "sciName"=>"Icterus galbula"},
        {"comName"=>"Yellow-bellied Flycatcher", "sciName"=>"Empidonax flaviventris"},
        {"comName"=>"Common Nighthawk", "sciName"=>"Chordeiles minor"}])
    end
  end
end

end

describe Chirp::Picture do
  let (:picture)

  describe ".initialize"

  describe "#get_picture"

end