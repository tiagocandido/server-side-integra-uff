class CoursesController < ContentsController

  private
    def set_adapter
      @adapter = CourseAdapter.new(params[:system], params.except(:system))
    end
end
