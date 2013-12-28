require_relative '../../test_helper'

class DateTestClass
  include Gish::DateHelpers
end

class TestDateHelpers < MiniTest::Test
  def setup
    @date_helper = DateTestClass.new
    @now = Time.new(2013,12,27)
  end

  def time_in_words time
    @date_helper.time_in_words(@now, time)
  end

  def test_seconds_ago
    assert_equal(time_in_words(Time.new(2013,12,27)), "less than one minute ago")
  end

  def test_minutes_ago
    assert_equal(time_in_words(Time.new(2013,12,26,23,58)), "2 minutes ago")
  end

  def test_about_an_hour_ago
    assert_equal(time_in_words(Time.new(2013,12,26,23,8)), "about 1 hour ago")
  end

  def test_x_hours_ago
    assert_equal(time_in_words(Time.new(2013,12,26,19)), "about 5 hours ago")
  end

  def test_x_days_ago
    assert_equal(time_in_words(Time.new(2013,12,23)), "4 days ago")
  end

  def test_x_months_ago
    assert_equal(time_in_words(Time.new(2013,9,23)), "3 months ago")
  end

  def test_about_x_years_ago
    assert_equal(time_in_words(Time.new(2011,12,27)), "about 2 years ago")
  end

  def test_about_x_years_ago
    assert_equal(time_in_words(Time.new(2011,9,27)), "more than 2 years ago")
  end

  def test_almost_x_years_ago
    assert_equal(time_in_words(Time.new(2011,2,27)), "almost 3 years ago")
  end

end
