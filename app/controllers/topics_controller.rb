class TopicsController < ContentsController

  private

    def set_adapter
      @adapter = TopicAdapter.new(params[:system], { token: params[:token] })
    end
end
