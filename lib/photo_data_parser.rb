# frozen_string_literal: false

require 'date'

# PhotoDataParser is a stateless utility class responsible for parsing a string of photo data.
# It provides functionality to reformat filenames based on city and timestamp,
# and can output a list of reformatted filenames. This class is designed to
# handle the grouping of photos by city, renaming files for uniformity, and
# maintaining the original order of the photos.
class PhotoDataParser
  # Parses the raw photo data string and returns an array of photo hashes.
  # @param data [String] the raw photo data as a newline-separated string.
  # @return [Array<Hash>] an array of photo hashes with filename, city, and timestamp.
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

  # Generates a string of reformatted filenames, each on a new line.
  # @param data [String] the raw photo data as a newline-separated string.
  # @return [String] a string of reformatted filenames, separated by newlines.
  def self.list_reformated_filenames(data)
    parsed_photos = parse(data)
    parsed_photos.map { |photo| photo[:filename] }.join("\n")
  end

  # Renames filenames in a sorted array of photo hashes, based on city group sizes.
  # @param sorted_photos [Array<Hash>] sorted array of photo hashes.
  # @param city_group_sizes [Hash] hash mapping city names to group size digits.
  # @return [void]
  def self.rename_filenames(sorted_photos, city_group_sizes)
    sorted_photos.each_with_index do |photo, index|
      group_size = city_group_sizes[photo[:city]]
      count_sufix = (index + 1).to_s.rjust(group_size, '0')
      file_type = File.extname(photo[:filename])

      photo[:filename] = "#{photo[:city]}#{count_sufix}#{file_type}"
    end
  end
  private_class_method :rename_filenames

  # Calculates the group sizes for each city in the photo collection.
  # @param photos_gouped_by_city [Hash] photos grouped by city.
  # @return [Hash] hash mapping each city to the size of its photo group.
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
