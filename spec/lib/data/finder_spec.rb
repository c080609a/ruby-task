# frozen_string_literal: true

require 'spec_helper'
require 'data/finder'
describe Finder do
  let(:reference) { '1' }
  let('campaigns') do
    [
      {
        'reference' => '1',
        'status' => 'enabled',
        'description' => 'Description for campaign 11'
      },
      {
        'reference' => '2',
        'status' => 'disabled',
        'description' => 'Other description for campaign'
      }
    ]
  end

  describe '.find_by_reference' do
    subject { described_class.new.find_by_reference(reference) }

    context 'when local data is empty' do
      it 'returns nil' do
        stub_const('LocalData::CAMPAIGNS', [])
        expect(subject).to eq(nil)
      end
    end

    context 'when local data is present' do
      before { stub_const('LocalData::CAMPAIGNS', campaigns) }

      context 'and campaign with reference exists' do
        it 'returns reference' do
          expect(subject).to eq(campaigns.first)
        end
      end

      context "and campaign with reference doesn't exists" do
        let(:reference) { '3' }
        it 'returns nil' do
          expect(subject).to eq(nil)
        end
      end
    end
  end
end
