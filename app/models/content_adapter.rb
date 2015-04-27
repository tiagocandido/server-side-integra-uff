class ContentAdapter
  def collection
    @strategy.all
  end

  def member(id)
    @strategy.find(id)
  end
end
