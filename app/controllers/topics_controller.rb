class TopicsController < ContentsController

  private

    def set_adapter
      @adapter = TopicAdapter.new(params[:system], params.except(:system))
    end
end
