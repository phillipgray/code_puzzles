class AccountNumberValidator
  def self.valid?(number)
    return false if number.include?('?')
    
    reversed_number_array = number.reverse.chars
    reversed_number_array
      .each_with_index
      .reduce(0) { |sum, (digit, i)| sum += (i + 1) * digit.to_i }
      .modulo(11)
      .zero?
  end
end
