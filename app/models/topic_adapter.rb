class TopicAdapter < ContentAdapter

  def initialize(plataform)
    set_strategy(plataform)
    super @strategy
  end

  def collection(course_id)
    @strategy.all(course_id)
  end

  def member(course_id, id)
    @strategy.find(course_id, id)
  end

  def set_strategy(plataform)
    @strategy ||= plataform.camelize.constantize::TopicStrategy.new
  end
end

