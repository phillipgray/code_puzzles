require './fibonacci.rb'

class Calculator
  def self.conditional_sum(limit)
    new.conditional_sum(limit)
  end

  def initialize(sequence_generator: Fibonacci)
    @sequence_generator = sequence_generator
  end

  def conditional_sum(limit)
    sequence_generator.sequence(limit).inject(0) do |total, number|
      meets_condition?(number) ? total += number : total
    end
  end

  private

  attr_reader :sequence_generator

  def meets_condition?(number)
    number.even?
  end
end
