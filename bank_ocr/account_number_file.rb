require_relative './account_number'

class AccountNumberFile
  def self.parse(path_to_file)
    account_number_file = new
    File.foreach(path_to_file).each_slice(4) do |lines|
      number_string = lines.take(3).join.delete("\n")
      account_number_file.account_numbers << AccountNumber.parse(number_string)
    end
    account_number_file
  end

  def initialize
    @account_numbers = []
  end

  attr_reader :account_numbers

  def write(path_to_file = nil)
    if path_to_file.nil?
      puts "\n"
      account_numbers.each { |account_number| puts construct_line(account_number) }
      puts "\n"
    else
      File.open(path_to_file, "w") do |file|
        account_numbers.each do |account_number|
          file << construct_line(account_number)
        end
      end
    end
  end

  def construct_line(account_number)
    line = account_number.to_s
    line += " #{account_number.error_code}" if account_number.error_code
    line + "\n"
  end
end
