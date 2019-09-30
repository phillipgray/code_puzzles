require 'spec_helper'
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
        expect(result).to eq('0' * 9)
      end

      it 'parses out a series of ones' do
        ones = <<-NUM.gsub(/\n/, '')
                           
  |  |  |  |  |  |  |  |  |
  |  |  |  |  |  |  |  |  |
NUM

        result = AccountNumber.parse(ones)
        expect(result).to eq('1' * 9)
      end

      it 'parses out a series of twos' do
        twos = <<-NUM.gsub(/\n/, '')
 _  _  _  _  _  _  _  _  _ 
 _| _| _| _| _| _| _| _| _|
|_ |_ |_ |_ |_ |_ |_ |_ |_ 
NUM

        result = AccountNumber.parse(twos)
        expect(result).to eq('2' * 9)
      end

      it 'parses out a series of threes' do
        threes = <<-NUM.gsub(/\n/, '')
 _  _  _  _  _  _  _  _  _ 
 _| _| _| _| _| _| _| _| _|
 _| _| _| _| _| _| _| _| _|
NUM

        result = AccountNumber.parse(threes)
        expect(result).to eq('3' * 9)
      end

      it 'parses out a series of fours' do
        fours = <<-NUM.gsub(/\n/, '')
                           
|_||_||_||_||_||_||_||_||_|
  |  |  |  |  |  |  |  |  |
NUM

        result = AccountNumber.parse(fours)
        expect(result).to eq('4' * 9)
      end

      it 'parses out a series of fives' do
        fives = <<-NUM.gsub(/\n/, '')
 _  _  _  _  _  _  _  _  _ 
|_ |_ |_ |_ |_ |_ |_ |_ |_ 
 _| _| _| _| _| _| _| _| _|
NUM

        result = AccountNumber.parse(fives)
        expect(result).to eq('5' * 9)
      end

      it 'parses out a series of sixes' do
        sixes = <<-NUM.gsub(/\n/, '')
 _  _  _  _  _  _  _  _  _ 
|_ |_ |_ |_ |_ |_ |_ |_ |_ 
|_||_||_||_||_||_||_||_||_|
NUM

        result = AccountNumber.parse(sixes)
        expect(result).to eq('6' * 9)
      end

      it 'parses out a series of sevens' do
        sevens = <<-NUM.gsub(/\n/, '')
 _  _  _  _  _  _  _  _  _ 
  |  |  |  |  |  |  |  |  |
  |  |  |  |  |  |  |  |  |
NUM

        result = AccountNumber.parse(sevens)
        expect(result).to eq('7' * 9)
      end

      it 'parses out a series of eights' do
        eights = <<-NUM.gsub(/\n/, '')
 _  _  _  _  _  _  _  _  _ 
|_||_||_||_||_||_||_||_||_|
|_||_||_||_||_||_||_||_||_|
NUM

        result = AccountNumber.parse(eights)
        expect(result).to eq('8' * 9)
      end

      it 'parses out a series of nines' do
        nines = <<-NUM.gsub(/\n/, '')
 _  _  _  _  _  _  _  _  _ 
|_||_||_||_||_||_||_||_||_|
 _| _| _| _| _| _| _| _| _|
NUM

        result = AccountNumber.parse(nines)
        expect(result).to eq('9' * 9)
      end
    end

    it 'parses out all digits' do
      nines = <<-NUM.gsub(/\n/, '')
    _  _     _  _  _  _  _ 
  | _| _||_||_ |_   ||_||_|
  ||_  _|  | _||_|  ||_| _|
NUM

      result = AccountNumber.parse(nines)
      expect(result).to eq('123456789')
    end
  end
end
