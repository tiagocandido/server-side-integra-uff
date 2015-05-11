class CourseAdapter < ContentAdapter

  def initialize(plataform)
    set_strategy(plataform)
    super @strategy
  end

  def set_strategy(plataform)
    @strategy ||= plataform.camelize.constantize::CourseStrategy.new
  end
end

