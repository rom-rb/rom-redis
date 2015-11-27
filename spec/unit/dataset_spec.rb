require 'rom/lint/spec'

describe ROM::Redis::Dataset do
  let(:conn)    { ::Redis::Namespace.new(:test) }
  let(:dataset) { ROM::Redis::Dataset.new(conn).set(:a, 1).set(:b, 2).get(:a) }
  let(:data)    { %w(OK OK 1) }

  it_behaves_like 'a rom enumerable dataset'
end
