class CourseAdapter < ContentAdapter

  def initialize(plataform, options = {})
    set_strategy(plataform, options)
    super @strategy
  end

  def set_strategy(plataform, options)
    @strategy ||= plataform.camelize.constantize::CourseStrategy.new(options)
  end
end

