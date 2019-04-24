# frozen_string_literal: true

require 'spec_helper'
require 'services/parse_data'
describe ParseData do
  let(:raw_data) do
    '{ "ads": [ { "reference": "1", "status": "enabled", "description": '\
    '"Description for campaign 11" }, { "reference": "2", "status": "disabled", '\
    '"description": "Description for campaign 12" }, { "reference": "3", "status": '\
    '"enabled", "description": "Description for campaign 13" } ] }'
  end

  subject { described_class.call(raw_data) }

  context 'when receive data' do
    it 'returns parsed ads data' do
      expect(subject).to eq(JSON.parse(raw_data)['ads'])
    end
  end
end
