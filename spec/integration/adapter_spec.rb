describe 'Adapter' do
  include_context 'container'

  before do
    configuration.relation(:users) do
      adapter :redis

      def by_id(id)
        hgetall(id)
      end
    end

    configuration.mappers do
      define(:users) do
        model User
        register_as :entity
      end
    end
  end

  it 'works' do
    rom.relations.users
      .hset(1, 'name', 'john doe')
      .hset(2, 'name', 'john snow')
      .to_a

    user = rom.relation(:users).as(:entity).by_id(1).to_a.first

    expect(user).to be_a(User)
    expect(user.name).to eq('john doe')
  end
end
