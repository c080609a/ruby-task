# frozen_string_literal: true

# Keeps local campaigns data
class LocalData
  CAMPAIGNS = [
    {
      'reference' => '1',
      'status' => 'enabled',
      'description' => 'Description for campaign 11'
    },
    {
      'reference' => '2',
      'status' => 'disabled',
      'description' => 'Other description for campaign'
    },
    {
      'reference' => '3',
      'status' => 'disabled',
      'description' => 'Just another description'
    }
  ].freeze
end
