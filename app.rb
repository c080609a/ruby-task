# frozen_string_literal: true

require './lib/services/parse_data'
require './lib/services/compare'

parsed_data = ParseData.call
p Compare.call(parsed_data)
