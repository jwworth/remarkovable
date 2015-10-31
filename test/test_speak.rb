require 'minitest/autorun'
require './lib/remarkovable.rb'

class TestSpeak < Minitest::Test
  def test_period_ending
    string = 'we are walking.'
    mc = Remarkovable.new(string: string)

    assert_match(/\A.*walking.*\.\z/, mc.speak)
  end

  def test_bang_ending
    string = 'we are walking!'
    mc = Remarkovable.new(string: string)

    assert_match(/\A.*walking.*!\z/, mc.speak)
  end

  def test_question_mark_ending
    string = 'we are walking?'
    mc = Remarkovable.new(string: string)

    assert_match(/\A.*walking.*\?\z/, mc.speak)
  end

  def test_custom_key
    string = "we are walking\n\rwe are talking we are walking."
    mc = Remarkovable.new(string: string)

    assert_match(/^We are./, mc.speak(custom_key: 'we are'))
  end

  def test_custom_key_no_match
    string = "we are walking\n\rwe are talking we are walking."
    mc = Remarkovable.new(string: string)

    assert_nil(mc.speak(custom_key: 'foo bar') =~ /Foo bar/i)
  end
end
