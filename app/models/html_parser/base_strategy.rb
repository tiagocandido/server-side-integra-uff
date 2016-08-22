module HtmlParser
  require 'nokogiri'

  class BaseStrategy
    include HTTParty

    def initialize(params)
      @url = params[:url]
      @dom_class = ''
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
        { code: 200, body: Nokogiri::HTML(page).css(@dom_class) }
      rescue
        { code: 400, body: 'Bad request' }
      end
  end
end
