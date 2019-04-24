# frozen_string_literal: true

require 'awesome_print'
require './lib/services/parse_data'
require './lib/services/compare_data'
require './lib/data/finder'

# Main application class
class App
  class << self
    def run
      raw_data = FetchData.call
      parsed_data = ParseData.call(raw_data)
      result = CompareData.call(parsed_data, Finder.new)
      ap result, indent: -2, index: false
    rescue StandardError => e
      ap "Something went wrong: #{e.message}"
    end
  end
end

App.run
