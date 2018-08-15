class RegexGenerator::CLI

  def initialize
    @generater = RegexGenerator::Base.new
    binding.pry
  end

  def example1
    settings = {
      true_test_casses: ['should match this', 'and this'],
      false_test_casses: ['but not this', 'or this'],
      max_length: 10
    }
    @generater = RegexGenerator::Base.new(settings)
    @generater.generate
  end

  def example2
    settings = {
      true_test_casses: ['aryedove@gmail.com', 'someuser@as.zu', 'som.d.ddf@ht.aththr.dgj'],
      false_test_casses: ['aryedove@gmailcom', 's@as.zu', 'somdddf@htt@hthr.dgj'],
      max_length: 20
    }
    @generater = RegexGenerator::Base.new(settings)
    @generater.generate
  end

  def example3
    settings = {
      true_test_casses: ['sjtdfty', 'fstjasdftjdzu', 'sodfaththr.dgj'],
      false_test_casses: ['aryedove@gmailcom', 's@as.zu', 'somdddf@htt@hthr.dgj'],
      max_length: 2
    }
    @generater = RegexGenerator::Base.new(settings)
    @generater.generate
  end
end
