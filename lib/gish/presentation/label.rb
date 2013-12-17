module Gish
  class Label
    def initialize(github_label)
      @name = github_label.name
      @color = github_label.color
    end

    def to_s
      "#{@color}  #{@name}"
    end
  end
end