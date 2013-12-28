module Gish
  module DateHelpers

    A_DAY = 1440
    A_MONTH = A_DAY*30
    A_YEAR = A_MONTH*12

    def time_in_words(now=Time.now, time)
      minutes = ((now - time)/60).round

      return format_year_string(minutes) if minutes >= A_YEAR

      case minutes
      when 0
        "less than one minute ago"
      when 1...50
        "#{minutes} minutes ago"
      when 51...90
        "about 1 hour ago"
      when 91...A_DAY
        "about #{hours_ago(minutes)} hours ago"
      when A_DAY...2520
        "one day ago"
      when 2521...A_MONTH
        "#{days_ago(minutes)} days ago"
      when A_MONTH...A_YEAR
        "#{months_ago(minutes)} months ago"
      end
    end

    private

    def format_year_string(minutes)
      remaining_minutes = minutes % A_YEAR

      if remaining_minutes < A_YEAR*0.25
        "about #{years_ago(minutes)} years ago"
      elsif remaining_minutes < A_YEAR*0.75
        "more than #{years_ago(minutes)} years ago"
      else
        "almost #{years_ago(minutes)+1} years ago"
      end
    end

    def hours_ago(minutes)
      minutes/60
    end

    def days_ago(minutes)
      hours_ago(minutes)/24
    end

    def months_ago(minutes)
      days_ago(minutes)/30
    end

    def years_ago(minutes)
      months_ago(minutes)/12
    end
  end
end
