module HtmlParser
  require 'nokogiri'

  class EventStrategy
    include HTTParty

    def initialize(params)
      @url = params[:url]
    end

    def all
      response = fetch
      response[:body] = response[:body].map { |resource| format resource }
      response
    end

    def find(id)
      response = fetch
      response[:body] = format(response[:body].css("##{id}").first)
      response
    end

    private

      def fetch
        page = HTTParty.get(@url)
        { code: 200, body: Nokogiri::HTML(page).css('.event') }
      rescue(message)
        { code: 400, body: 'Bad request: ' + message }
      end

      def format(event)
        {
          id: "html_parser-#{@url}-#{event.attr('id')}",
          system: "html_parser",
          system_id: event.attr('id'),
          starts: event.css('.starts').text,
          ends: event.css('.ends').text,
          name: event.css('.name').text,
          info: event.css('.info').text,
          course_id: "html_parser-#{@url}"
        }
      end
  end
end
