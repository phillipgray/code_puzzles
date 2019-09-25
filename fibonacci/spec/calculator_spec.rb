require 'spec_helper'
require_relative '../calculator'

RSpec.describe Calculator do
  describe '#conditional_sum' do
    it 'returns the sum of elements that meet the condition (even numbers)' do
      easy_sequence = [1, 2, 3, 4].each
      dummy_generator = double(Fibonacci, sequence: easy_sequence)
      calculator = Calculator.new(sequence_generator: dummy_generator)

      expect(calculator.conditional_sum(nil)).to eq(6)
    end
  end

  describe 'full integration specs' do
    it 'returns the sum of the even elements of the fibonacci sequence under 10' do
      expect(Calculator.conditional_sum(10)).to eq(10)
    end

    it 'returns the sum of the even elements of the fibonacci sequence under 4 million' do
      expect(Calculator.conditional_sum(4_000_000)).to eq(4613732)
    end
  end
end
