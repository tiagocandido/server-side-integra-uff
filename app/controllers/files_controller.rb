class FilesController < ContentsController

  private

  def set_adapter
    @adapter = FileAdapter.new(params[:system], { token: params[:token] })
  end
end
