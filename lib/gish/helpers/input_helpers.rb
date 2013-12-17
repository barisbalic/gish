module Gish
  module InputHelpers
    def prompt(message)
      print message
      STDIN.gets.chomp
    end

    def confirm(message)
      print message
      STDIN.gets.chomp == 'y'
    end

    def capture_editor_input(content=nil)
      unique_file = "/tmp/#{random_filename}"
      File.open(unique_file, 'w+'){|f| f.write(content) }

      command = "#{Gish.editor} #{unique_file} < `tty` > `tty`"
      %x{#{command}}
      ouput = %x{cat #{unique_file}}
      
      File.delete(unique_file)
      ouput.length < 1 ? nil : ouput
    end

    def random_filename
      (0...10).map { (65 + rand(26)).chr }.join
    end
  end
end