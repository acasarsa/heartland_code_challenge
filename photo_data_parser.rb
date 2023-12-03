require 'date'
require 'byebug'

# parse photo data and return new filenames in original order separated by a newline
class PhotoDataParser
  def self.parse(data)
    photo_info = data.split("\n")

    photos = []

    photo_info.each do |str|
      filename, city, timestamp = str.split(', ')
      photos << { filename:, city:, timestamp: DateTime.parse(timestamp) }
    end

    grouped_by_city = photos.group_by { |photo| photo[:city] }

    formatted_photo_str = ''
    grouped_by_city.each do |city, city_photos|
      group_size = city_photos.size.to_s.size

      sorted_photos = city_photos.sort_by { |photo| photo[:timestamp] }

      sorted_photos.each_with_index do |photo, index|
        city = photo[:city]
        file_type = File.extname(photo[:filename])
        count = index + 1
        count_sufix = count.to_s.rjust(group_size, '0')
        photo[:filename] = "#{city}#{count_sufix}#{file_type}"
      end
    end

    photos.each do |photo|
      formatted_photo_str << "#{photo[:filename]}\n"
    end
    formatted_photo_str
  end
end

sample_data = "photo.jpg, Krakow, 2013-09-05 14:08:15
Mike.png, London, 2015-06-20 15:13:22
myFriends.png, Krakow, 2013-09-05 14:07:13
Eiffel.jpg, Florianopolis, 2015-07-23 08:03:02
pisatower.jpg, Florianopolis, 2015-07-22 23:59:59
BOB.jpg, London, 2015-08-05 00:02:03
notredame.png, Florianopolis, 2015-09-01 12:00:00
me.jpg, Krakow, 2013-09-06 15:40:22
a.png, Krakow, 2016-02-13 13:33:50
b.jpg, Krakow, 2016-01-02 15:12:22
c.jpg, Krakow, 2016-01-02 14:34:30
d.jpg, Krakow, 2016-01-02 15:15:01
e.png, Krakow, 2016-01-02 09:49:09
f.png, Krakow, 2016-01-02 10:55:32
g.jpg, Krakow, 2016-02-29 22:13:11"

puts PhotoDataParser.parse(sample_data)

