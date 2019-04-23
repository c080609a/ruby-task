# frozen_string_literal: true

require 'spec_helper'
require 'services/fetch_data'
describe FetchData do
  subject { described_class.call }

  let(:response) do
    '{ "ads": [ { "reference": "1", "status": "enabled", "description": '\
    '"Description for campaign 11" }, { "reference": "2", "status": "disabled", '\
    '"description": "Description for campaign 12" }, { "reference": "3", "status": '\
    '"enabled", "description": "Description for campaign 13" } ] }'
  end

  before do
    allow(Net::HTTP).to receive(:get).and_return(response)
  end

  context 'when api is down' do
    before do
      allow(Net::HTTP).to receive(:get).and_return(SocketError)
    end

    it 'throws http error' do
      expect(subject).to eq(SocketError)
    end
  end

  context 'when api is up' do
    it 'returns json string' do
      expect(subject).to eq(response)
    end
  end
end
