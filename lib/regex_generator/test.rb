class RegexGenerator::Test
  attr_accessor :test
  
  def initialize(test = nil, should_match = true)
    self.test = test
    self.should_match = should_match
  end
  
  def should_match?
    @should_match
  end

  def should_match=(bool)
    @should_match = !!bool
  end

  def passes?(regex)
    # why is '!!' necessary
    !!test.match(regex) == should_match?
  end
end

# examples should return true

# RegexGenerator::Test.new('a').passes?(/a/)
# RegexGenerator::Test.new('a', false).passes?(/b/)
