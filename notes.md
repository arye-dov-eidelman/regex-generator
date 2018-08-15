# Regex Generator Notes

- `RegexGenerator::Base`
  - `generator`
    - create tests.
    - build regex.
    - repeat above step until it passes the tests.
    - score the regex.
    - optimize it.
    - optionally repeat the above 3 steps to get better scores.

  - `test`

  - `build` - Generate valid regular expressions save it as an attribute.

  - `score` - readabilty, speed, specificity.

  - `optimizer`

Each test should be an instance of test (🚀👩‍🔬), not a string attribute of RegexGenerator.

`RegexGenerator::test` test
RegexGenerator::Test.new(/a/).passes?('a')
