# frozen_string_literal: true

require 'json'
require_relative 'fetch_data'
require_relative 'application_service'

# Parses data
class ParseData < ApplicationService
  def call(data)
    parse_data(data)
  end

  private

  def parse_data(data)
    JSON.parse(data)['ads']
  end
end
