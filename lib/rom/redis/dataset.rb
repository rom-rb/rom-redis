module ROM
  module Redis
    class Dataset
      attr_reader :connection, :commands

      def initialize(connection, commands = [])
        @connection = connection
        @commands   = commands
      end

      def to_a
        view
      end

      def each(&block)
        view.each(&block)
      end

      def method_missing(command, *args, &block)
        self.class.new(connection, commands.clone.push([command, args, block]))
      end

    private

      def view
        commands.map do |command, args, block|
          connection.send(command, *args) # do we need to provide blocks?
        end
      end
    end
  end
end
