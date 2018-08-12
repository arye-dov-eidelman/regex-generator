class RegexGenerator::Base
  attr_accessor :true_test_casses, :false_test_casses, :top_results, :final_result, :allowed_regex_chars, :randomizer, :max_length


  def initialize(setup_hash)
    @allowed_regex_chars = ['\d', '\w', '\s', '\D', '\W', '\S', '+', '*', '?', '.', '\.', '\?', '\*', '\+']
    @randomizer = Random.new
    
    @max_length = setup_hash[:max_length] || 8
    @true_test_casses = setup_hash[:true_test_casses] || []
    @false_test_casses = setup_hash[:false_test_casses] || []
  end

  def random_char
    [
      allowed_regex_chars.sample,
      ('a'..'z').to_a.sample,
      ('A'..'Z').to_a.sample,
      ('0'..'9').to_a.sample
    ].sample
  end
  
  def random_regex(length = randomizer.rand(1..max_length))
    length.times.collect{random_char}.join
  end

  def generate

  end
end
