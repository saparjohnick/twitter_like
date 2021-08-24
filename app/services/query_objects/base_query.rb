class BaseQuery
  attr_accessor :relation

  class << self
    delegate :new, to: :call
  end

  def initialize(relation = default_relation)
    @relation = relation
  end

  def default_relation
    raise NotImplementedError, 'no @relation provided'
  end

  def call
    raise NotImplementedError, 'call method must implement query logic'
  end
end
