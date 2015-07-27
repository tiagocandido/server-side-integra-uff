class EventsController < ApplicationController
  before_filter :set_adapter

  def index
    render json: @adapter.collection
  end

  def show
    render json: @adapter.member(params[:id])
  end

  private

    def set_adapter
      @adapter = EventAdapter.new(params[:system], { token: request.headers["AUTHORIZATION"] })
    end
end
