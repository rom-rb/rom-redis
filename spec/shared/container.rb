RSpec.shared_context 'container' do
  let(:container)      { ROM.container(configuration) }
  let!(:configuration) { ROM::Configuration.new(:redis).use(:macros) }
  let(:gateway)        { configuration.gateways[:default] }
  let(:rom)            { container }
end
