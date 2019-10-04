require 'spec_helper'
require_relative '../account_number_validator'

describe AccountNumberValidator do
  describe '.valid?' do
    it 'returns true when a number is valid' do
      result = AccountNumberValidator.valid?('457508000')
      expect(result).to eq(true)
    end

    it 'returns false when a number is invalid' do
      result = AccountNumberValidator.valid?('664371495')
      expect(result).to eq(false)
    end

    it 'returns false when the number contains a question mark' do
      result = AccountNumberValidator.valid?('?23456213')
      expect(result).to eq(false)
    end
  end
end
