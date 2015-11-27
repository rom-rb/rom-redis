describe ROM::Redis::Relation do
  let!(:env) do
    env = ROM::Environment.new
    env.setup(:redis)
    env.use(:auto_registration)
    env
  end

  let(:rom) { env.finalize.env }

  subject { rom.relation(:users) }

  before do
    env.relation(:users)
  end

  it '#set' do
    expect(subject.set(:a, 1).to_a).to eq(['OK'])
  end

  it '#hset' do
    expect(subject.hset(:who, :is, :john).to_a).to eq([true])
  end

  it '#hget' do
    subject.hset(:users, :john, :doe).to_a

    expect(subject.hgetall(:users).to_a).to eq([{ 'john' => 'doe' }])
  end
end
