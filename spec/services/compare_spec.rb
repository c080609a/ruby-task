# frozen_string_literal: true

require 'spec_helper'
require 'services/compare'
describe Compare do

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
        'description' => 'Other description for campain'
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
  let(:diff) { [] }

  subject { described_class.call(remote_data) }

  context 'when compare data' do
    context 'and local and remote are equal' do
      it 'returns empty array' do
        expect(subject).to eq(diff)
      end
    end

    context 'and there are differences between local and remote' do
      let(:status) { 'enabled' }
      let(:description) { 'Completely different description' }
      let(:diff) do
        [
          {
            remote_reference: '2',
            discrepancies: [
              {
                status: {
                  local: 'disabled',
                  remote: status
                }
              }
            ]
          },
          {
            remote_reference: '3',
            discrepancies: [
              {
                status: {
                  local: 'disabled',
                  remote: status
                }
              },
              {
                description: {
                  local: 'Just another description',
                  remote: description
                }
              }
            ]
          }
        ]
      end

      it 'returns array of diffs' do
        expect(subject).to eq(diff)
      end
    end

    context 'and there is extra remote data' do
      let(:another_remote_data) do
        remote_data.push(
          'reference' => '4',
          'status' => 'disabled',
          'description' => 'description'
        )
      end

      subject { described_class.call(remote_data) }

      it 'returns array of diffs' do
        expect(subject).to eq(diff)
      end
    end

    context 'and there is no remote data' do
      let(:remote_data) { [] }

      it 'returns array of diffs' do
        expect(subject).to eq(diff)
      end
    end
  end
end
