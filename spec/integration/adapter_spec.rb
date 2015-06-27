describe 'ROM / Redis / Setup' do
  let(:setup) { ROM.setup(:redis) }
  let(:rom)   { setup.finalize }
  subject     { rom.relations.users }

  before do
    class User
      attr_reader :name

      def initialize(name)
        @name = name
      end
    end

    setup.relation(:users) do
      def by_id(id)
        hget(:users, id)
      end
    end

    setup.mappers do
      define(:users) do
        model User
        register_as :entity
      end
    end

    setup.commands(:users) do
      define :create
    end
  end

  it 'works' do
    rom.relations.users.hset(:users, 1, 'john doe').hset(:users, 2, 'john snow').to_a

    user = rom.relation(:users).by_id(1).as(:entity).to_a.first

    expect(user).to be_a(User)
    expect(user.name).to eq('john doe')
  end
end
