require_relative './spec_helper'
require_relative '../account_number_file'
require 'fileutils'

describe AccountNumberFile do
  describe 'integration specs' do
    it 'can load, parse account numbers, and write a summary file' do
      fixture_file = File.join(File.dirname(__FILE__), "/fixtures", "use_case_3_input.txt")
      file = AccountNumberFile.parse(fixture_file)

      aggregate_failures do
        account_numbers = file.account_numbers.map(&:to_s)
        expect(account_numbers).to contain_exactly('000000051', '000000057', '1234?678?')

        temporary_output_file = File.join(File.dirname(__FILE__), "/tmp", "test_output.txt")
        file.write(temporary_output_file)

        expected_output_file = File.join(File.dirname(__FILE__), "/fixtures", "use_case_3_output.txt")
        expect(FileUtils.identical?(temporary_output_file, expected_output_file)).to eq(true)
      end
    end
  end
end
