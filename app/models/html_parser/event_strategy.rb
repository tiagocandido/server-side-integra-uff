module HtmlParser
  class EventStrategy < BaseStrategy
    def initialize(params)
      super(params)
      @dom_class = '.event'
    end

    private
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
