# frozen_string_literal: true

require 'spec_helper'
require 'services/compare_data'
describe CompareData do
  let(:remote_data) do
    [
      {
        'reference' => '1',
        'status' => 'enabled',
        'description' => 'Description for campaign 11'
      },
      {
        'reference' => '2',
        'status' => status,
        'description' => 'Other description for campaign'
      },
      {
        'reference' => '3',
        'status' => status,
        'description' => description
      }
    ]
  end

  let(:status) { 'disabled' }
  let(:description) { 'Just another description' }

  subject { described_class.call(remote_data) }

  context 'when local and remote are equal' do
    let(:expected_diff) { [] }
    it 'returns empty array' do
      expect(subject).to eq(expected_diff)
    end
  end

  context 'when there are differences between local and remote' do
    let(:status) { 'enabled' }
    let(:description) { 'Completely different description' }
    let(:expected_diff) do
      [
        {
          'remote_reference' => '2',
          'discrepancies' => [
            {
              'status' => {
                'local' => 'disabled',
                'remote' => status
              }
            }
          ]
        },
        {
          'remote_reference' => '3',
          'discrepancies' => [
            {
              'status' => {
                'local' => 'disabled',
                'remote' => status
              }
            },
            {
              'description' => {
                'local' => 'Just another description',
                'remote' => description
              }
            }
          ]
        }
      ]
    end

    it 'returns empty array of diffs' do
      expect(subject).to eq(expected_diff)
    end
  end

  context 'when there is extra remote data' do
    let(:another_remote_data) do
      remote_data.push(
        'reference' => '4',
        'status' => 'disabled',
        'description' => 'description'
      )
    end
    let(:expected_diff) { [] }

    subject { described_class.call(remote_data) }

    it 'returns empty array of diffs' do
      expect(subject).to eq(expected_diff)
    end
  end

  context 'when there is no remote data' do
    let(:remote_data) { [] }
    let(:expected_diff) { [] }

    it 'returns empty array of diffs' do
      expect(subject).to eq(expected_diff)
    end
  end
end
