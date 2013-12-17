module Gish
  module Commands
    module Label
      def list_labels
        labels = request { client.labels(Gish.repository) }
        labels.map{|l| Gish::Label.new(l) }
      end

      def delete_labels(labels)
        labels.each do |l|
          request { client.delete_label!(Gish.repository, l) }
        end
      end

      def update_label(name, new_name, color)
        opts = {:name => new_name}
        opts[:color] = color unless color.nil?

        request { client.update_label(Gish.repository, name, opts) }
      end

      def create_label(name, color=nil)
        request { client.add_label(Gish.repository, name, color) }
      end
    end
  end
end