# frozen_string_literal: true

require 'json'
require_relative 'fetch_data'
require_relative 'application_service'

class ParseData < ApplicationService
  def call
    parse_data
  end

  private

  def parse_data
    JSON.parse(data)['ads']
  end

  def data
    FetchData.call
  end
end
