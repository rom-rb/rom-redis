require 'rom/lint/spec'

describe ROM::Redis::Gateway do
  let(:gateway)    { ROM::Redis::Gateway }
  let(:uri)        { Hash[] }
  let(:identifier) { :redis }

  it_behaves_like 'a rom gateway'
end
