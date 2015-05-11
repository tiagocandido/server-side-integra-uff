class TopicsController < ApplicationController
  before_filter :set_adapter

  def index
    render json: @adapter.collection(params[:course_id])
  end

  def show
    render json: @adapter.member(params[:course_id], params[:id])
  end

  private

    def set_adapter
      @adapter = TopicAdapter.new(params[:system])
    end
end
