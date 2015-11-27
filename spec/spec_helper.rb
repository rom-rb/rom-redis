# encoding: utf-8

require 'bundler'
Bundler.setup

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

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
