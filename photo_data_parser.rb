# frozen_string_literal: false

require 'date'
require 'byebug'

# parse photo data and return new filenames in original order separated by a newline
class PhotoDataParser
  def self.parse(data)
    parsed_photos = data.split("\n").map do |photo_info|
      filename, city, timestamp = photo_info.split(', ')
      { filename:, city:, timestamp: DateTime.parse(timestamp) }
    end

    photos_grouped_by_city = parsed_photos.group_by { |photo| photo[:city] }
    city_group_sizes = calculate_group_sizes(photos_grouped_by_city)

    photos_grouped_by_city.each_value do |city_photos|
      sorted_photos = city_photos.sort_by { |photo| photo[:timestamp] }
      rename_filenames(sorted_photos, city_group_sizes)
    end
    parsed_photos
  end

  def self.list_reformated_filenames(data)
    parsed_photos = parse(data)
    parsed_photos.map { |photo| photo[:filename] }.join("\n")
  end

  def self.rename_filenames(sorted_photos, city_group_sizes)
    sorted_photos.each_with_index do |photo, index|
      group_size = city_group_sizes[photo[:city]]
      count_sufix = (index + 1).to_s.rjust(group_size, '0')
      file_type = File.extname(photo[:filename])

      photo[:filename] = "#{photo[:city]}#{count_sufix}#{file_type}"
    end
  end
  private_class_method :rename_filenames

  # returns a hash
  def self.calculate_group_sizes(photos_gouped_by_city)
    photos_gouped_by_city.transform_values { |group| group.size.to_s.size }
  end
  private_class_method :calculate_group_sizes
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

puts PhotoDataParser.list_reformated_filenames(sample_data)
