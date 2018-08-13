class RegexGenerator::Base
  attr_accessor :true_test_casses, :false_test_casses, :allowed_regex_chars, :max_length
  attr_reader :final_result, :randomizer #,  :top_results


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

    begin
      Regexp.new(length.times.collect{random_char}.join)
    rescue
      random_regex(length)
    end
  end

  def passes_tests(regex)
    true_test_casses.all? { |test_case| test_case =~ regex} &&
    false_test_casses.none? { |test_case| test_case =~ regex}
  end

  def solved?
    !!final_result
  end

  def number_with_delimiter(number)
    number.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
  end

  def generate
    count = 0
    time = Time.now

    while !solved?
      regex = random_regex
      if passes_tests(regex)
        final_result = regex
        puts "Regex: \/#{regex}\/"
        return "done"
      else
        # binding.pry
        print "Regex: #{regex},#{' ' * (max_length + 16 - regex.to_s.length)}  "
        print "try: #{number_with_delimiter(count += 1)},  "
        puts  "Microseconds #{((Time.now - time)* 1_000_000.0).to_i}"
        time = Time.now
      end
    end
  end
end
