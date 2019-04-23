# frozen_string_literal: true

require 'spec_helper'
require 'services/parse_data'
describe ParseData do
  subject { described_class.call }

  let(:raw_data) do
    '{ "ads": [ { "reference": "1", "status": "enabled", "description": '\
    '"Description for campaign 11" }, { "reference": "2", "status": "disabled", '\
    '"description": "Description for campaign 12" }, { "reference": "3", "status": '\
    '"enabled", "description": "Description for campaign 13" } ] }'
  end

  before do
    allow(FetchData).to receive(:call).and_return(raw_data)
  end

  context 'when receive data' do
    it 'returns parsed data' do
      expect(subject).to eq(JSON.parse(raw_data)['ads'])
    end
  end
end
