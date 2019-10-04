require_relative './spec_helper'
require_relative '../account_number'

describe AccountNumber do
  describe '.parse' do
    context 'repeated series' do
      it 'parses out a series of zeros' do
        zeros = <<-NUM.gsub(/\n/, '')
 _  _  _  _  _  _  _  _  _ 
| || || || || || || || || |
|_||_||_||_||_||_||_||_||_|
NUM

        result = AccountNumber.parse(zeros)
        expect(result.to_s).to eq('0' * 9)
      end

      it 'parses out a series of ones' do
        ones = <<-NUM.gsub(/\n/, '')
                           
  |  |  |  |  |  |  |  |  |
  |  |  |  |  |  |  |  |  |
NUM

        result = AccountNumber.parse(ones)
        expect(result.to_s).to eq('1' * 9)
      end

      it 'parses out a series of twos' do
        twos = <<-NUM.gsub(/\n/, '')
 _  _  _  _  _  _  _  _  _ 
 _| _| _| _| _| _| _| _| _|
|_ |_ |_ |_ |_ |_ |_ |_ |_ 
NUM

        result = AccountNumber.parse(twos)
        expect(result.to_s).to eq('2' * 9)
      end

      it 'parses out a series of threes' do
        threes = <<-NUM.gsub(/\n/, '')
 _  _  _  _  _  _  _  _  _ 
 _| _| _| _| _| _| _| _| _|
 _| _| _| _| _| _| _| _| _|
NUM

        result = AccountNumber.parse(threes)
        expect(result.to_s).to eq('3' * 9)
      end

      it 'parses out a series of fours' do
        fours = <<-NUM.gsub(/\n/, '')
                           
|_||_||_||_||_||_||_||_||_|
  |  |  |  |  |  |  |  |  |
NUM

        result = AccountNumber.parse(fours)
        expect(result.to_s).to eq('4' * 9)
      end

      it 'parses out a series of fives' do
        fives = <<-NUM.gsub(/\n/, '')
 _  _  _  _  _  _  _  _  _ 
|_ |_ |_ |_ |_ |_ |_ |_ |_ 
 _| _| _| _| _| _| _| _| _|
NUM

        result = AccountNumber.parse(fives)
        expect(result.to_s).to eq('5' * 9)
      end

      it 'parses out a series of sixes' do
        sixes = <<-NUM.gsub(/\n/, '')
 _  _  _  _  _  _  _  _  _ 
|_ |_ |_ |_ |_ |_ |_ |_ |_ 
|_||_||_||_||_||_||_||_||_|
NUM

        result = AccountNumber.parse(sixes)
        expect(result.to_s).to eq('6' * 9)
      end

      it 'parses out a series of sevens' do
        sevens = <<-NUM.gsub(/\n/, '')
 _  _  _  _  _  _  _  _  _ 
  |  |  |  |  |  |  |  |  |
  |  |  |  |  |  |  |  |  |
NUM

        result = AccountNumber.parse(sevens)
        expect(result.to_s).to eq('7' * 9)
      end

      it 'parses out a series of eights' do
        eights = <<-NUM.gsub(/\n/, '')
 _  _  _  _  _  _  _  _  _ 
|_||_||_||_||_||_||_||_||_|
|_||_||_||_||_||_||_||_||_|
NUM

        result = AccountNumber.parse(eights)
        expect(result.to_s).to eq('8' * 9)
      end

      it 'parses out a series of nines' do
        nines = <<-NUM.gsub(/\n/, '')
 _  _  _  _  _  _  _  _  _ 
|_||_||_||_||_||_||_||_||_|
 _| _| _| _| _| _| _| _| _|
NUM

        result = AccountNumber.parse(nines)
        expect(result.to_s).to eq('9' * 9)
      end
    end

    it 'parses out all digits' do
      nines = <<-NUM.gsub(/\n/, '')
    _  _     _  _  _  _  _ 
  | _| _||_||_ |_   ||_||_|
  ||_  _|  | _||_|  ||_| _|
NUM

      result = AccountNumber.parse(nines)
      expect(result.to_s).to eq('123456789')
    end

    context 'when the number is invalid' do
      it 'parses the number and sets the error code to ERR' do
        invalid_num = <<-NUM.gsub(/\n/, '')
    _  _  _  _  _  _     _ 
|_||_|| || ||_   |  |  ||_ 
  | _||_||_||_|  |  |  | _|
NUM

        result = AccountNumber.parse(invalid_num)
        aggregate_failures do
          expect(result.to_s).to eq('490067715')
          expect(result.error_code).to eq('ERR')
        end
      end
    end

    context 'when the number has illegible/unreadable charactures' do
      it 'parses the number and sets the error code to ERR' do
        invalid_num = <<-NUM.gsub(/\n/, '')
    _  _  _  _  _  _     _ 
|_||_|| || ||_   |  |  | _ 
  | _||_||_||_|  |  |  | _|
NUM

        result = AccountNumber.parse(invalid_num)
        aggregate_failures do
          expect(result.to_s).to eq('49006771?')
          expect(result.error_code).to eq('ILL')
        end
      end
    end
  end

  describe '.lookup_digit' do
    it 'returns the digit matching the character string if present' do
      four = '   |_|  |'
      expect(AccountNumber.lookup_digit(four)).to eq('4')
    end

    it 'returns a question mark if the character string has no match' do
      nonsense = 'bananas_foster'
      expect(AccountNumber.lookup_digit(nonsense)).to eq('?')
    end
  end

  describe '#error_code' do
    let(:validator) { double(AccountNumberValidator, valid?: is_valid) }
    subject(:account_number) { described_class.new(number, validator: validator) }

    context 'when the number includes a question mark (illegible character)' do
      let(:number) { '89?248274' }
      let(:is_valid) { false }

      it 'returns ILL' do
        expect(account_number.error_code).to eq('ILL')
      end
    end

    context 'when the number is invalid' do
      let(:number) { '892248274' }
      let(:is_valid) { false }

      it 'returns ERR' do
        expect(account_number.error_code).to eq('ERR')
      end
    end

    context 'when the number is valid' do
      let(:number) { '892248274' }
      let(:is_valid) { true }

      it 'returns nil' do
        expect(account_number.error_code).to be_nil
      end
    end
  end

  describe '#to_s' do
    it 'returns the account number as a string' do
      number = AccountNumber.new('012345678')
      expect(number.to_s).to eq('012345678')
    end
  end

  describe '#inspect' do
    it 'returns a helpful summary of the object' do
      number = AccountNumber.new('012345678')
      expect(number.inspect).to eq("<AccountNumber: '012345678'>")
    end
  end
end
