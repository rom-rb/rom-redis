require 'redis'
require 'redis/namespace'

require 'rom/gateway'
require 'rom/redis/dataset'

module ROM
  module Redis
    class Gateway < ROM::Gateway
      adapter :redis

      attr_reader :datasets

      def initialize(options = {})
        @connection = ::Redis.new(options)
        @datasets   = {}
      end

      def [](name)
        datasets.fetch(name.to_s)
      end

      def dataset(name)
        datasets[name.to_s] = Dataset.new(namespace(name))
      end

      def dataset?(name)
        datasets.key?(name.to_s)
      end

      private

      def namespace(name)
        ::Redis::Namespace.new(name.to_s, redis: @connection)
      end
    end
  end
end
