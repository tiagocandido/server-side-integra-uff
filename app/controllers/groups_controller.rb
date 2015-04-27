class GroupsController < ApplicationController
  before_filter :set_adapter

  def index
    return @adapter.collection
  end

  def show
    return @adapter.member(params[:id])
  end

  private

    def set_adapter
      @adapter = GroupAdapter.new(params[:plataform])
    end
end
