require 'minitest/autorun'
require './lib/remarkovable.rb'

class TestMarkovModel < Minitest::Test
  def test_add_pair_simple_case
    string = 'we walk.'
    mc = Remarkovable.new(string: string)
    expected_output = {
      'we walk' => ['.']
    }

    assert_equal expected_output, mc.markov_model
  end

  def test_string_is_nil
    assert_raises ArgumentError do
      Remarkovable.new(string: nil)
    end
  end

  def test_add_pair_three_words_and_punctuation
    string = 'we (are) walking.'
    mc = Remarkovable.new(string: string)
    expected_output = {
      'we (are)' => ['walking'],
      '(are) walking' => ['.']
    }

    assert_equal expected_output, mc.markov_model
  end

  def test_add_pair_three_words_and_spaces
    string = 'we are  walking.'
    mc = Remarkovable.new(string: string)
    expected_output = {
      'we are' => ['walking'],
      'are walking' => ['.']
    }

    assert_equal expected_output, mc.markov_model
  end

  def test_add_pair_three_words_and_quotes
    string = 'we are "walking".'
    mc = Remarkovable.new(string: string)
    expected_output = {
      'we are' => ['"walking"'],
      'are "walking"' => ['.']
    }

    assert_equal expected_output, mc.markov_model
  end

  def test_add_pair_key_duplication
    string = 'we are walking we are talking we are walking.'
    mc = Remarkovable.new(string: string)
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
    string = "we are walking\n\rwe are talking we are walking."
    mc = Remarkovable.new(string: string)
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
    string = 'we are.'
    mc = Remarkovable.new(string: string, prefix_length: 1)
    expected_output = {
      'we' => ['are'],
      'are' => ['.']
    }

    assert_equal expected_output, mc.markov_model
  end

  def test_custom_prefix_length_3
    string = 'we are walking.'
    mc = Remarkovable.new(string: string, prefix_length: 3)
    expected_output = {
      'we are walking' => ['.']
    }

    assert_equal expected_output, mc.markov_model
  end

  def test_custom_prefix_length_4
    string = 'we are walking talking.'
    mc = Remarkovable.new(string: string, prefix_length: 4)
    expected_output = {
      'we are walking talking' => ['.']
    }

    assert_equal expected_output, mc.markov_model
  end

  def test_custom_prefix_length_5
    string = 'we are walking talking singing.'
    mc = Remarkovable.new(string: string, prefix_length: 5)
    expected_output = {
      'we are walking talking singing' => ['.']
    }

    assert_equal expected_output, mc.markov_model
  end

  def test_no_terminator
    string = 'we are walking'

    assert_raises ArgumentError do
      Remarkovable.new(string: string)
    end
  end
end
