require 'spec_helper'
require_relative '../fibonacci'

RSpec.describe Fibonacci do
  describe '.sequence' do
    it 'yields expected numbers' do
      numbers = described_class.sequence(6).collect
      expect(numbers).to contain_exactly(1, 2, 3, 5)
    end

    it 'does not include numbers equal to or over the limit specified' do
      numbers = described_class.sequence(5).collect
      expect(numbers).not_to include(5)
    end
  end
end
