class RegexGenerator::Generater
  attr_accessor :tests, :solution
  def initialize
    @tests = []
    @build_attempt_count = 0
    @builder = RegexGenerator::Builder
    @tester = RegexGenerator::Test
  end

  def add_test_case(test, should_match = true)
    @tests << RegexGenerator::Test.new(test, should_match)
  end

  def add_test_cases(tests_array)
    tests_array.each do |test|
      should_match = test[1].nil? ? true : test[1]
      add_test_case(test[0], should_match)
    end
  end

  def find_passing_regex
    regex = build_regex
    while !@tester.passes_all?(tests, regex)
      regex = build_regex
    end

    @solution = RegexGenerator::Solution.new(tests, regex)

    puts ''
    puts "attempt number  " + @build_attempt_count.to_s
    puts "sulotion:       " + @solution.to_s
    puts "score:          " + @solution.score.to_s

    # @solution
  end

  private

  def build_regex
    @build_attempt_count += 1
    @builder.build
  end
end
