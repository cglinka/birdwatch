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

  describe "#get_loc" do #get_list?
    it "returns an array of objects " do
      list=double("list")

      allow(list).to receive(:jsonlist).and_return([
        {"comName"=>"Baltimore Oriole", "sciName"=>"Icterus galbula"},
        {"comName"=>"Yellow-bellied Flycatcher", "sciName"=>"Empidonax flaviventris"},
        {"comName"=>"Common Nighthawk", "sciName"=>"Chordeiles minor"}])
    end
  end
end

describe Chirp::Picture do

  describe ".initialize" do

  end

  describe "#get_picture" do
    it "takes a scientific name and returns an image URL via Flickr." do
      name = "Chordeiles minor"
      picture = '{ "photos": { "page": 1, "pages": "533", "perpage": 1, "total": "533", 
    "photo": [ { "id": "503934066", "owner": "10458155@N00", "secret": "bfbcb366c9", "server": "222", "farm": 1, "title": "Eastern Wood-Pewee", "ispublic": 1, "isfriend": 0, "isfamily": 0, "url_q": "http:\/\/farm1.staticflickr.com\/222\/503934066_bfbcb366c9_q.jpg", "height_q": "150", "width_q": "150" }
    ] }, "stat": "ok" }'

      
    end
  end

end