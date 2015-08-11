class CoursesController < ContentsController

  private
    def set_adapter
      @adapter = CourseAdapter.new(params[:system], { token: params[:token] })
    end
end
