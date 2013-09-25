require_relative "../lib/birdwatch.rb"

describe Chirp::Location  do
  let (:loc){Chirp::Location.new([30.25000, -97.75000])}
  let (:locdist){Chirp::Location.new([30.25000, -97.75000], 10)}

  describe ".initialize" do
    context "When no distance is inputed" do
      it 'sets latitude, longitude, and distance of 5' do
        expect(loc.lat).to eq(30.25)
        expect(loc.long).to eq(-97.75)
        expect(loc.dist).to eq(1)
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

# Not actually testing anything right now
  describe "#get_list" do
    it "returns an array of objects " do
      list=double("list")

      allow(list).to receive().and_return([
        {"comName"=>"Baltimore Oriole", "sciName"=>"Icterus galbula"},
        {"comName"=>"Yellow-bellied Flycatcher", "sciName"=>"Empidonax flaviventris"},
        {"comName"=>"Common Nighthawk", "sciName"=>"Chordeiles minor"}])

      expect().to receive().and_return()
      expect().to receive().and_return()
    end
  end
end

describe Chirp::Content do
  let(:list) {[
        {"comName"=>"Baltimore Oriole", "sciName"=>"Icterus galbula"},
        {"comName"=>"Yellow-bellied Flycatcher", "sciName"=>"Empidonax flaviventris"},
        {"comName"=>"Common Nighthawk", "sciName"=>"Chordeiles minor"}
  ]}
  let(:testobj){Chirp::Content.new(list)}

  describe ".initialize" do
    context 'takes an Array of Hashes and creates a new Chirp::Content Object' do
      it 'sets Chirp::Content.new(list).list = list' do
        expect(testobj.list).is_a?(Array)
        expect(testobj.sci_name_list).is_a?(Array)
        expect(testobj.sci_name_list).to eq([])
      end
    end
  end

  describe "#flickr_call" do
    it 'takes a scientific name and returns a Ruby Hash object' do
      allow(:testobj).to receive(:flickr_call).and_return([{"id"=>"505840094", "owner"=>"86442142@N00", "secret"=>"3c663af34a", "server"=>"190", "farm"=>1, "title"=>"Baltimore Oriole (male)", "ispublic"=>1, "isfriend"=>0, "isfamily"=>0, "url_q"=>"http://farm1.staticflickr.com/190/505840094_3c663af34a_q.jpg", "height_q"=>"150", "width_q"=>"150"}])

      expect(testobj.flickr_call("Icterus galbula")).is_a?(Hash)
      # expect(testobj.flickr_call("Icterus galbula")).to eq({"id"=>"505840094", "owner"=>"86442142@N00", "secret"=>"3c663af34a", "server"=>"190", "farm"=>1, "title"=>"Baltimore Oriole (male)", "ispublic"=>1, "isfriend"=>0, "isfamily"=>0, "url_q"=>"http://farm1.staticflickr.com/190/505840094_3c663af34a_q.jpg", "height_q"=>"150", "width_q"=>"150"})
    end
  end




  describe "#get_pic_url" do
    it "takes a Hash object and returns an image URL." do
      
      expect(testobj.get_pic_url()).to eq()
    end
  end

end