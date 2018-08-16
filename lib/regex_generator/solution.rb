class RegexGenerator::Solution
  attr_accessor :regex, :tests, :score
  def initialize(tests, regex)
    @tests = tests
    @regex = regex
    @score = RegexGenerator::Score.new(self)
    @optimizer = RegexGenerator::Optimizer.new(self)
  end

  def optimize
    @optimizer.optimize
  end

  def length
    @regex.source.length
  end

  def to_s
    @regex.source
  end
end
