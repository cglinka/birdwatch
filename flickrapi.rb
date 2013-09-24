require 'json'
require 'flickraw'

string = '{
    "photos": {
        "page": 1,
        "pages": "166",
        "perpage": 1,
        "total": "166",
        "photo": [
            {
                "id": "3910530658",
                "owner": "41159843@N05",
                "secret": "d31cdcc2ab",
                "server": "3094",
                "farm": 4,
                "title": "Chimney Swift in flight",
                "ispublic": 1,
                "isfriend": 0,
                "isfamily": 0
            }
        ]
    },
    "stat": "ok"
}'

photos = JSON.parse(string)

puts photos

photo = photos["photos"]

puts photo

# pic_url = FlickRaw.url_b(photos)

# puts pic_url