class EventsController < ContentsController

  private
    def set_adapter
      @adapter = EventAdapter.new(params[:system], params.except(:system))
    end
end
