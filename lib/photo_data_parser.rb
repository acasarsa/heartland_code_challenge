# frozen_string_literal: true

require 'date'

# PhotoDataParser is a stateless utility class responsible for parsing a string of photo data.
# It provides functionality to reformat filenames based on city and timestamp,
# and can output a list of reformatted filenames. This class is designed to
# handle the grouping of photos by city, renaming files for uniformity, and
# maintaining the original order of the photos.
class PhotoDataParser
  # Parses the raw photo data string and returns an array of photo hashes.
  #
  # @param data [String] the raw photo data as a newline-separated string.
  # @return [Array<Hash>] an array of photo hashes with new filename, city, and timestamp.
  def self.parse(data)
    return [] if data.strip.empty?

    parsed_photos = data.split("\n").filter_map do |photo_info|
      parsed_line = parse_line(photo_info) # filter_map map removes nil values here if any found
      next unless parsed_line

      filename, city, timestamp = parsed_line
      { filename:, city:, timestamp: }
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
  #
  # @param data [String] the raw photo data as a newline-separated string.
  # @return [String] a string of reformatted filenames, separated by newlines.
  def self.list_reformatted_filenames(data)
    parsed_photos = parse(data)
    parsed_photos.map { |photo| photo[:filename] }.join("\n")
  end

  # Parses an individual line of photo data and handles potential errors.
  # This method ensures the line has the correct format and all necessary data fields.
  #
  # @param photo_info [String] A single line of photo data.
  # @return [Array<String, String, DateTime>, nil] An array containing filename, city, and timestamp
  # if the line is valid, or nil if it's invalid.
  def self.parse_line(photo_info)
    return unless photo_info.count(',') == 2

    filename, city, timestamp_string = photo_info.split(', ').map(&:strip)
    return nil if [filename, city, timestamp_string].any?(&:empty?)

    timestamp = parse_timestamp(timestamp_string)
    return nil unless timestamp

    [filename, city, timestamp]
  end
  private_class_method :parse_line

  # Attempts to parse a given timestamp string into a DateTime object.
  # If the timestamp string is invalid, it catches the ArgumentError and returns nil.
  #
  # @param timestamp_string [String] The timestamp string to be parsed.
  # @return [DateTime, nil] The parsed DateTime object if the string is a valid timestamp, or nil if it's invalid.
  def self.parse_timestamp(timestamp_string)
    DateTime.parse(timestamp_string)
  rescue ArgumentError
    nil
  end
  private_class_method :parse_timestamp

  # Renames filenames in a sorted array of photo hashes, based on city group sizes.
  #
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
  #
  # @param photos_gouped_by_city [Hash] photos grouped by city.
  # @return [Hash] hash mapping each city to the size of its photo group.
  def self.calculate_group_sizes(photos_gouped_by_city)
    photos_gouped_by_city.transform_values { |group| group.size.to_s.size }
  end
  private_class_method :calculate_group_sizes
end
