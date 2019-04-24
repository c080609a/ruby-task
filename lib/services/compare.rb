# frozen_string_literal: true

require 'json'
require 'pry'
require_relative 'application_service'

class Compare < ApplicationService
  LOCAL_DATA = [
    {
      'reference' => '1',
      'status' => 'enabled',
      'description' => 'Description for campaign 11'
    },
    {
      'reference' => '2',
      'status' => 'disabled',
      'description' => 'Other description for campain'
    },
    {
      'reference' => '3',
      'status' => 'disabled',
      'description' => 'Just another description'
    }
  ].freeze

  def call(remote_data)
    compare(remote_data)
  end

  private

  def compare(remote_data)
    [].tap do |diff_result|
      remote_data.each do |remote_item|
        reference = remote_item['reference']
        local_item = find_by_reference(reference)
        item_diff = diff(remote_item, local_item)
        next if item_diff.empty?

        diff_result << build_response(reference, item_diff, remote_item, local_item)
      end
    end
  end

  def diff(remote_item, local_item)
    (remote_item.keys & local_item.keys).reject { |k| local_item[k] == remote_item[k] }
  end

  def find_by_reference(reference)
    local_data.find { |item| item['reference'] == reference }
  end

  def build_response(reference, item_diff, remote, local)
    {
      "remote_reference": reference,
      "discrepancies": build_discrepancies(item_diff, remote, local)
    }
  end

  def build_discrepancies(item_diff, remote, local)
    [].tap do |discrepancies|
      item_diff.each do |diff|
        discrepancies.push(
          diff.to_sym => {
            remote: remote[diff],
            local: local[diff]
          }
        )
      end
    end
  end

  def local_data
    LOCAL_DATA
  end
end
