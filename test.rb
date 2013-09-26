"query"=>{"pages"=>{"384367"=>{"pageid"=>384367, "ns"=>0, "title"=>"Baltimore Oriole", "extract"=>"<p>The <b>Baltimore Oriole</b> (<i>Icterus galbula</i>) is a small icterid blackbird that commonly occurs in eastern North America as a migratory breeding bird."}}}} 

def get_wiki(name)
    extract = Wikipedia.find(name, :prop => "extracts").json
    extract = JSON.parse(extract)
    extract =extract["query"]
    markup = {}
    extract.each do |key, pages|
        pages.each do |key, num|
            num.each do |key, info|
                markup = info
            end
        end
    end
end





require 'wikipedia'
require 'json'
test = {"query"=>{"pages"=>{"384367"=>{"pageid"=>384367, "ns"=>0, "title"=>"Baltimore Oriole", "extract"=>"<p>The <b>Baltimore Oriole</b> (<i>Icterus galbula</i>) is a small icterid blackbird that commonly occurs in eastern North America as a migratory breeding bird."}}}} 