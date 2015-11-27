class User
  attr_reader :name

  def initialize(attrs)
    @name = attrs.fetch('name', nil)
  end
end
