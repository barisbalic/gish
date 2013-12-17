module Gish
  module TerminalHelpers
    def console_width
      size = %x{stty size}
      size.split(' ').last
    end

    def bold(message)
      "\033[1m#{message}\033[0m"
    end

    def underline(message)
      "\033[4m#{message}\033[0m"
    end

    def format_label(label)
      "\033[30m\033[47m #{label} \033[0m"
    end
  end
end