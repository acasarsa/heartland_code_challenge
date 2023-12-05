#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/photo_data_parser.rb'
require_relative 'spec/support/mock_data'

puts PhotoDataParser.list_reformatted_filenames(MockData::INPUT_DATA)
# uncomment below to see the return for the parse method
# puts PhotoDataParser.parse(MockData::INPUT_DATA).inspect
