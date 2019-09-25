class Fibonacci
  def self.sequence(limit)
    Enumerator.new do |yielded_number|
      first = 1
      second = 1
      until second >= limit do
        yielded_number << second
        new_second = first + second
        first = second
        second = new_second
      end
    end
  end
end
