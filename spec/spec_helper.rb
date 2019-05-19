# encoding: utf-8

if RUBY_ENGINE == 'ruby' && RUBY_VERSION >= '2.4.0' && ENV['CI'] == 'true'
  require 'simplecov'
  SimpleCov.start do
    add_filter '/spec/'
  end
end

require 'rom-redis'

root = Pathname(__FILE__).dirname

Dir[root.join('shared/*.rb').to_s].each { |f| require f }
Dir[root.join('support/*.rb').to_s].each { |f| require f }

RSpec.configure do |config|
  config.before do
    Redis.current.flushall
  end

  config.after do
    Redis.current.flushall
  end
end
