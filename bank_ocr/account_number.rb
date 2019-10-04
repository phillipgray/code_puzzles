require_relative './account_number_validator'

class AccountNumber
  CHARACTER_MAP = {
    ' _ | ||_|' => '0',
    '     |  |' => '1',
    ' _  _||_ ' => '2',
    ' _  _| _|' => '3',
    '   |_|  |' => '4',
    ' _ |_  _|' => '5',
    ' _ |_ |_|' => '6',
    ' _   |  |' => '7',
    ' _ |_||_|' => '8',
    ' _ |_| _|' => '9'
  }.freeze

  def self.parse(string)
    raw_characters = Array.new(9,'')

    string.chars.each_slice(27) do |line|
      line.each_slice(3).with_index do |character_fragment, i|
        raw_characters[i] += character_fragment.join
      end
    end

    final = raw_characters.inject([]) do |numbers, character_string|
      numbers << lookup_digit(character_string)
    end

    new(final.join)
  end

  def self.lookup_digit(character_string)
    CHARACTER_MAP[character_string] || '?'
  end

  def initialize(number, validator: AccountNumberValidator)
    @number = number
    @validator = validator
    @is_valid = validator.valid?(@number)
    @error_code = assign_error_code
  end

  attr_reader :error_code

  def to_s
    number
  end

  def inspect
    "<AccountNumber: '#{number}'>"
  end

  private

  attr_reader :number, :is_valid

  def valid?
    is_valid
  end

  def assign_error_code
    case
    when number.include?('?')
      'ILL'
    when !valid?
      'ERR'
    end
  end
end
