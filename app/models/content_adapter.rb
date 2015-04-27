class ContentAdapter
  def initialize(strategy)
    @strategy = strategy
  end

  def collection
    @strategy.all
  end

  def member(id)
    @strategy.find(id)
  end
end
