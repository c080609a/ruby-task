# frozen_string_literal: true

require 'net/http'
require_relative 'application_service'

# Fetches remote data
class FetchData < ApplicationService
  DATA_URI = 'https://mockbin.org/bin/fcb30500-7b98-476f-810d-463a0b8fc3df'
  private_constant :DATA_URI

  def call
    fetch_data
  end

  private

  def fetch_data
    Net::HTTP.get(data_url)
  end

  def data_url
    URI(DATA_URI)
  end
end
