# frozen_string_literal: true

require 'awesome_print'
require './lib/services/parse_data'
require './lib/services/compare'

parsed_data = ParseData.call
ap Compare.call(parsed_data), indent: -2, index: false
