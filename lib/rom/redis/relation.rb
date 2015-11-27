require 'redis/namespace'
require 'rom/relation'

module ROM
  module Redis
    class Relation < ROM::Relation
      adapter :redis

      forward(*::Redis::Namespace::COMMANDS.keys.map(&:to_sym))
    end
  end
end
