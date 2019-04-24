# frozen_string_literal: true

require 'awesome_print'
require './lib/services/parse_data'
require './lib/services/compare_data'

class App
  class << self
    def run
      parsed_data = ParseData.call
      ap CompareData.call(parsed_data), indent: -2, index: false
    rescue StandardError => e
      ap "Something went wrong: #{e.message}"
    end
  end
end

App.run
