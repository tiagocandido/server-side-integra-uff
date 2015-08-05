module ConexaoUff
  class TopicStrategy
    include HTTParty
    API_URL = 'http://homologacao.sti.uff.br/conexaouff/api/v1/'

    def initialize(params)
      @params = params
    end

    def all(grupo_id)
      topics = fetch("/grupos/#{grupo_id}/topicos")
      topics.map { |topic| format topic }
    end

    def find(grupo_id, id)
      topic = fetch("/grupos/#{grupo_id}/topicos/" + id)
      format(topic)
    end

    private

      def format(attributes)
        { system: "conexao_uff",
          system_id: attributes["id"],
          created_at: attributes["created_at"],
          updated_at: attributes['updated_at'],
          name: attributes['nome'],
          creator_id: attributes['usuario_id'],
          group_id: attributes['grupo_id']
        }
      end

      def fetch(path)
        response = HTTParty.get(API_URL + path)
        JSON.parse(response.body)
      end
  end
end
