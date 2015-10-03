require 'minitest/autorun'
require './lib/remarkovable.rb'

class RemarkovableTest < Minitest::Test
  def test_add_pair_simple_case
    content = 'we are walking'
    mc = Remarkovable.new(content)
    expected_output = {
      'we are' => ['walking']
    }

    assert_equal expected_output, mc.markov_model
  end

  def test_add_pair_nil
    content = nil
    mc = Remarkovable.new(content)
    expected_output = nil

    assert_equal nil, mc.speak
  end

  def test_add_pair_three_words_and_punctuation
    content = 'we (are) walking.'
    mc = Remarkovable.new(content)
    expected_output = {
      'we (are)' => ['walking'],
      '(are) walking' => ['.']
    }

    assert_equal expected_output, mc.markov_model
  end

  def test_add_pair_three_words_and_spaces
    content = 'we are  walking.'
    mc = Remarkovable.new(content)
    expected_output = {
      'we are' => ['walking'],
      'are walking' => ['.']
    }

    assert_equal expected_output, mc.markov_model
  end

  def test_add_pair_three_words_and_quotes
    content = 'we are "walking".'
    mc = Remarkovable.new(content)
    expected_output = {
      'we are' => ['"walking"'],
      'are "walking"' => ['.']
    }

    assert_equal expected_output, mc.markov_model
  end

  def test_add_pair_key_duplication
    content = 'we are walking we are talking we are walking.'
    mc = Remarkovable.new(content)
    expected_output = {
      'we are' => %w(walking talking walking),
      'are walking' => ['we', '.'],
      'walking we' => ['are'],
      'are talking' => ['we'],
      'talking we' => ['are']
    }

    assert_equal expected_output, mc.markov_model
  end

  def test_add_pair_with_newlines
    content = "we are walking\n\rwe are talking we are walking."
    mc = Remarkovable.new(content)
    expected_output = {
      'we are' => %w(walking talking walking),
      'are walking' => ['we', '.'],
      'walking we' => ['are'],
      'are talking' => ['we'],
      'talking we' => ['are']
    }

    assert_equal expected_output, mc.markov_model
  end

  def test_custom_prefix_length_1
    content = "we are."
    mc = Remarkovable.new(content, 1)
    expected_output = {
      'we' => ['are'],
      'are' => ['.']
    }

    assert_equal expected_output, mc.markov_model
  end

  def test_custom_prefix_length_3
    content = "we are walking."
    mc = Remarkovable.new(content, 3)
    expected_output = {
      'we are walking' => ['.']
    }

    assert_equal expected_output, mc.markov_model
  end

  def test_custom_prefix_length_4
    content = "we are walking talking."
    mc = Remarkovable.new(content, 4)
    expected_output = {
      'we are walking talking' => ['.']
    }

    assert_equal expected_output, mc.markov_model
  end

  def test_custom_prefix_length_5
    content = "we are walking talking singing."
    mc = Remarkovable.new(content, 5)
    expected_output = {
      'we are walking talking singing' => ['.']
    }

    assert_equal expected_output, mc.markov_model
  end

  def test_custom_key
    content = "we are walking\n\rwe are talking we are walking."
    mc = Remarkovable.new(content)
    expected_output = /^We are./

    assert_match expected_output, mc.speak('we are')
  end

  def test_custom_key_no_match
    content = "we are walking\n\rwe are talking we are walking."
    mc = Remarkovable.new(content)

    assert_nil mc.speak('foo bar') =~ /Foo bar/i
  end
end
