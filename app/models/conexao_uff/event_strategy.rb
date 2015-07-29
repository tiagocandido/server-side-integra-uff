module ConexaoUff
  class EventStrategy
    include HTTParty
    #API_URL = 'http://homologacao.sti.uff.br/conexaouff/api/v1/'
    API_URL = 'http://localhost:3001/api/v1/'

    def initialize(params)
      @params = params
    end

    def all
      events = fetch("/eventos")
      events.map { |event| format event }
    end

    def find(id)
      event = fetch("/eventos/#{id}")
      format(event)
    end

    private

      def format(attributes)
        { system: "conexao_uff",
          system_id: attributes["id"],
          starts: attributes["inicio"],
          ends: attributes['fim'],
          name: attributes['titulo'],
          info: attributes['info'],
          course_id: attributes['grupo_id']
        }
      end

      def fetch(path)
        response = HTTParty.get(API_URL + path, { headers: { 'AUTHORIZATION' => "#{@params[:token]}" } })
        JSON.parse(response.body)
      end
  end
end
