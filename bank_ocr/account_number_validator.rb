class AccountNumberValidator
  def self.valid?(number)
    sum = number.reverse.chars.each_with_index.reduce(0) do |sum, (digit, i)|
      sum += (i + 1) * digit.to_i
    end
    sum % 11 == 0
  end
end
