# frozen_string_literal: true

require 'spec_helper'
require 'data/finder'
describe Finder do
  let(:proper_item) do
    {
      'reference' => '1',
      'status' => 'enabled',
      'description' => 'Description for campaign 11'
    }
  end

  subject { described_class.new }

  describe '.find_by_reference' do
    it 'returns parsed ads data' do
      expect(subject.find_by_reference('1')).to eq(proper_item)
    end
  end
end
