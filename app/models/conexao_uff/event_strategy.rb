module ConexaoUff
  class EventStrategy
    include HTTParty
    API_URL = 'http://homologacao.sti.uff.br/conexaouff/api/v1/'

    def all(grupo_id)
      events = fetch("/grupos/#{grupo_id}/eventos")
      events.map { |event| format event }
    end

    def find(grupo_id, id)
      event = fetch("/grupos/#{grupo_id}/eventos/" + id)
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
          group_id: attributes['grupo_id']
        }
      end

      def fetch(path)
        response = HTTParty.get(API_URL + path)
        JSON.parse(response.body)
      end
  end
end
