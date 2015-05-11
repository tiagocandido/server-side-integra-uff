class CoursesController < ApplicationController
  before_filter :set_adapter

  def index
    render json: @adapter.collection
  end

  def show
    render json: @adapter.member(params[:id])
  end

  private

    def set_adapter
      @adapter = CourseAdapter.new(params[:system])
    end
end
