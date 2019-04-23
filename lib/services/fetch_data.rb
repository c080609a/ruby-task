# frozen_string_literal: true

require 'net/http'
require_relative 'application_service'

class FetchData < ApplicationService
  DATA_URI = 'https://mockbin.org/bin/fcb30500-7b98-476f-810d-463a0b8fc3df'.freeze

  def call
    fetch_data
  end

  private

  def fetch_data
    Net::HTTP.get(uri)
  end

  def uri
    URI(DATA_URI)
  end
end
