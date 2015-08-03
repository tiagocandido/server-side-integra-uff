class CoursesController < ApplicationController
  before_filter :set_adapter

  def index
    collection = @adapter.collection
    render json: collection[:body], status: collection[:code]
  end

  def show
    member = @adapter.member(params[:id])
    render json: member[:body], status: member[:status]
  end

  private

  def set_adapter
    @adapter = CourseAdapter.new(params[:system], { token: params[:token] })
  end
end
