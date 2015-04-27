class GroupsAdapter < ContentAdapter
  def initialize(plataform)
    plataform = plataform.camelize.constantize
    @strategy = plataform::GroupsStrategy
  end
end

