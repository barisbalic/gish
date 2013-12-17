module Gish
  module Commands
    module Label
      def list_labels
        labels = request( Proc.new{ client.labels(Gish.repository) })
        labels.map{|l| Gish::Label.new(l) }
      end

      def delete_labels(labels)
        labels.each do |l|
          request( Proc.new{ client.delete_label!(Gish.repository, l) })
        end
      end

      def update_label(name, new_name, color)
        opts = {:name => new_name}
        opts[:color] = color unless color.nil?

        request( Proc.new{ client.update_label(Gish.repository, name, opts) })
      end

      def create_label(name, color=nil)
        request( Proc.new{ client.add_label(Gish.repository, name, color) })
      end

      private

      def request(proc)
        begin
          proc.call
        rescue Octokit::NotFound
          puts "Could not find the specified label."
          exit 1
        rescue Octokit::Unauthorized
          puts "Something is wrong with your personal access token."
          exit 1          
        end
      end

    end
  end
end