class RegexGenerator::CLI

  def initialize
    @generater = RegexGenerator::Base.new(true_test_casses: ('a'..'z').to_a, false_test_casses: ['1', '3','8'], max_length: 8)
  end

  def run
    @generater.generate
  end
end
