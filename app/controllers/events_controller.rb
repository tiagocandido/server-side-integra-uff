class EventsController < ContentsController

  private
    def set_adapter
      @adapter = EventAdapter.new(params[:system], { token: params[:token] })
    end
end
