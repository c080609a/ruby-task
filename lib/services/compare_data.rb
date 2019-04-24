# frozen_string_literal: true

require 'json'
require_relative 'application_service'
require_relative '../data/finder'

# Compares remote and local data and shows diff
class CompareData < ApplicationService
  def call(remote_data, finder = nil)
    @finder = finder || Finder.new
    compare(remote_data)
  end

  private

  attr_reader :finder

  def compare(remote_data)
    remote_data.each_with_object([]) do |remote_item, diff_result|
      reference = remote_item['reference']
      local_item = finder.find_by_reference(reference)
      item_diff = diff(remote_item, local_item)
      next if item_diff.empty?

      diff_result << build_response(reference, item_diff, remote_item, local_item)
    end
  end

  def diff(remote_item, local_item)
    (remote_item.keys & local_item.keys).reject { |k| remote_item[k] == local_item[k] }
  end

  def build_response(reference, item_diff, remote, local)
    {
      'remote_reference' => reference,
      'discrepancies' => build_discrepancies(item_diff, remote, local)
    }
  end

  def build_discrepancies(item_diff, remote, local)
    item_diff.map do |field|
      {
        field => {
          'remote' => remote[field],
          'local' => local[field]
        }
      }
    end
  end
end
