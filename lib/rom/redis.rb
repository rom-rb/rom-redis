require 'json'
require 'redic'
require 'rom'

module ROM
  module Redis
    class Relation < ROM::Relation
      forward :get

      def insert(object)
        dataset << object
        self
      end
    end

    class Dataset
      include Equalizer.new(:name, :connection)

      attr_reader :name, :connection

      def initialize(name, connection)
        @name = name
        @connection = connection
      end

      def each(&block)
        with_set { |set| set.each(&block) }
      end

      def insert(object)
        with_set do |set|
          set << object
          connection.call('SET', name, JSON.dump(set))
        end
        self
      end
      alias_method :<<, :insert

      private

      def with_set
        yield(JSON.load(connection.call('GET', name)))
      end
    end

    class Repository < ROM::Repository
      attr_reader :sets

      def initialize
        @connection = Redic.new
        @sets = {}
      end

      def dataset(name)
        connection.call('SET', name, []) unless dataset?(name)
        sets[name] = Dataset.new(name, connection)
      end

      def [](name)
        sets.fetch(name)
      end

      def dataset?(name)
        connection.call('GET', name)
      end
    end
  end
end

ROM.register_adapter(:redis, ROM::Redis)
