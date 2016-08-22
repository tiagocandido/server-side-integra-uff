module HtmlParser
  class FileStrategy < BaseStrategy
    def initialize(params)
      super(params)
      @dom_class = '.file'
    end

    private

      def format(file)
        {
          id: "html_parser-#{@url}-#{file.attr('id')}",
          system: "html_parser",
          system_id: file.attr('id'),
          description: file.css('.description').text,
          course_id: "html_parser-#{@url}",
          owner: file.css('.owner').text,
          file_name: file.css('.file_name').text,
          content_type: file.css('.content_type').text,
          file_size: file.css('.file_size').text,
          download_url: file.css('.download_url').text,
        }
      end
  end
end
