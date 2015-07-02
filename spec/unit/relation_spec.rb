describe ROM::Redis::Relation do
  let(:setup) { ROM.setup(:redis) }
  let(:rom)   { setup.finalize }
  subject     { rom.relations.users }

  before do
    setup.relation(:users)
  end

  it '#set' do
    expect(subject.set(:a, 1).to_a).to eq(['OK'])
  end

  it '#hset' do
    expect(subject.hset(:who, :is, :john).to_a).to eq([true])
  end

  it '#hget' do
    subject.hset(:users, :john, :doe).to_a

    expect(subject.hgetall(:users).to_a).to eq([{'john' => 'doe'}])
  end
end
