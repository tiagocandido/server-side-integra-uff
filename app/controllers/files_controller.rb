class FilesController < ContentsController

  private

  def set_adapter
    @adapter = FileAdapter.new(params[:system], params.except(:system) )
  end
end
