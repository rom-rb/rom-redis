require 'spec_helper'

require 'rom/lint/spec'

describe ROM::Redis::Repository do
  let(:repository) { ROM::Redis::Repository }
  let(:uri) { nil }

  it_behaves_like "a rom repository" do
    let(:identifier) { :redis }
  end
end
