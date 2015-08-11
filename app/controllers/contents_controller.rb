class ContentsController < ApplicationController
  before_filter :set_adapter

  def index
    collection = @adapter.collection
    render json: collection[:body], status: collection[:code]
  end

  def show
    member = @adapter.member(params[:id])
    render json: member[:body], status: member[:code]
  end
end
