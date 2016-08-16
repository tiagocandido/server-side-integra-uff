module HtmlParser
  require 'nokogiri'

  class FileStrategy
    include HTTParty

    def initialize(params)
      @url = params[:url]
    end

    def all
      response = fetch
      response[:body] = response[:body].map { |resource| format resource } if response[:code] == 200
      response
    end

    def find(id)
      response = fetch
      response[:body] = format(response[:body].css("##{id}").first) if response[:code] == 200
      response
    end

    private

      def fetch
        page = HTTParty.get(@url)
        { code: 200, body: Nokogiri::HTML(page).css('.file') }
      rescue
        { code: 400, body: 'Bad request' }
      end

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
