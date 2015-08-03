module ConexaoUff
  class EventStrategy
    include HTTParty
    #API_URL = 'http://homologacao.sti.uff.br/conexaouff/api/v1/'
    API_URL = 'http://localhost:3001/api/v1/'

    def initialize(params)
      @params = params
    end

    def all
      response = fetch("/eventos")
      if response[:code] == 200
        response[:body] = JSON.parse(response[:body]).map { |event| format_event event }
      end
      response
    end

    def find(id)
      response = fetch("/eventos/#{id}")
      if response[:code] == 200
        response[:body] = format_event(JSON.parse(response[:body]))
      end
      response
    end

    private

      def format_event(attributes)
        {
          id: "conexao_uff-#{attributes['id']}",
          system: "conexao_uff",
          system_id: attributes["id"],
          starts: attributes["inicio"],
          ends: attributes['fim'],
          name: attributes['titulo'],
          info: attributes['info'],
          course_id: attributes['grupo_id']
        }
      end

      def fetch(path)
        response = HTTParty.get(API_URL + path, { headers: { 'AUTHORIZATION' => "Token token=#{@params[:token]}" } })

        { code: response.code, body: response.body }
      end
  end
end
