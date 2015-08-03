class EventsController < ApplicationController
  before_filter :set_adapter

  def index
    collection = @adapter.collection

    render json: collection[:body], status: collection[:status]
  end

  def show
    member = @adapter.member(params[:id])

    render json: member[:body], status: member[:status]
  end

  private

    def set_adapter
      @adapter = EventAdapter.new(params[:system], { token: params[:token] })
    end
end
