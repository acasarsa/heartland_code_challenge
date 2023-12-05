# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PhotoDataParser do
  describe '.parse' do
    it 'parses raw photo data string and returns an array of photo hashes with new filename, city, and timestamp' do
      parsed_data = PhotoDataParser.parse(MockData::INPUT_DATA)

      expect(parsed_data).to eq MockData::EXPECTED_OUTPUT_FROM_PARSE
    end

    it 'can parse 100 photos' do
      parsed_data = PhotoDataParser.parse(MockData::INPUT_DATA_100)

      expect(parsed_data).to be_an(Array)
      expect(parsed_data.first).to have_key(:filename)
      expect(parsed_data.first).to have_key(:city)
      expect(parsed_data.first).to have_key(:timestamp)

      expect(parsed_data.first[:city]).to eq('London')
      expect(parsed_data.first[:timestamp]).to be_a(DateTime)
    end

    it 'returns an empty array if input is empty' do
      expect(PhotoDataParser.parse('')).to eq []
    end
  end

  describe '.list_reformatted_filenames' do
    it 'generates a string of reformatted filenames, each on a new line when given valid input' do
      reformatted_filenames = PhotoDataParser.list_reformatted_filenames(MockData::INPUT_DATA)

      expect(reformatted_filenames).to eq MockData::EXPECTED_OUTPUT_NEW_FILENAMES
    end

    it 'can reformat 100 photos' do
      reformatted_filenames = PhotoDataParser.list_reformatted_filenames(MockData::INPUT_DATA_100)

      expect(reformatted_filenames).to eq MockData::EXPECTED_OUTPUT_100
    end

    it 'handles otherwise valid data with leading and trailing whitespaces' do
      data_with_whitespaces = " photo1.jpg , London , 2020-01-01 10:00:00 \nphoto2.jpg, London, 2020-01-01 10:00:00 "
      output = PhotoDataParser.list_reformatted_filenames(data_with_whitespaces)

      expect(output).to eq "London1.jpg\nLondon2.jpg"
    end

    it 'skips and does not include in group count data that is invalidly formatted' do
      # empty input, lines with missing fields, and invalid timestamps are skipped
      output = PhotoDataParser.list_reformatted_filenames(MockData::INCLUDES_INVALID_DATA)
      expect(output).to eq MockData::EXPECTED_OUTPUT_MIXED_INVALID
    end
  end
end
