class AccountNumberFile
  CHAR_MAP = {
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
  }

  def self.parse_page(filename)
  end

  def self.parse(string)
    raw = Array.new(9,'')

    string.chars.each_slice(27) do |line|
      line.each_slice(3).with_index do |char, i|
        raw[i] += char.join
      end
    end

    final = raw.inject([]) do |numbers, char_string|
      numbers << CHAR_MAP[char_string]
    end

    final.join
  end

  def initialize(account_numbers)
    @account_numbers = account_numbers
  end

end
