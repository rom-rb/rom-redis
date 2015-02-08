require 'spec_helper'

describe 'ROM / Redis / Setup' do
  before do
    ROM.setup(:redis)
  end

  after do
    ROM.env.repositories[:default].connection.call('SET', 'users', [])
  end

  let(:rom) { ROM.finalize.env }

  it 'works' do
    class Users < ROM::Relation[:redis]
    end

    users = rom.relations.users

    users.insert('id' => 1, 'name' => 'Piotr')

    expect(users.to_a).to eql([{ 'id' => 1, 'name' => 'Piotr' }])
  end
end
