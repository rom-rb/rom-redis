require 'rom'
require 'rom/redis/version'
require 'rom/redis/relation'
require 'rom/redis/gateway'

ROM.register_adapter(:redis, ROM::Redis)
