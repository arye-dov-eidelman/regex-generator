class RegexGenerator::Score

  def initialize(solution)
    @solution = solution
  end

  def overall
    speed * 100_000 + length
  end

  def speed
    starting_time = Time.now
    RegexGenerator::Test.passes_all?(@solution.tests, @solution.regex)
    total_time = Time.now - starting_time
    speed = total_time / @solution.tests.length
  end

  def length
    @solution.length
  end
end
