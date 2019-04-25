# frozen_string_literal: true

require_relative 'local_data'

# Finds campaigns in local storage
class Finder
  def find_by_reference(reference)
    local_data.find { |item| item['reference'] == reference }
  end

  private

  def local_data
    LocalData::CAMPAIGNS
  end
end
