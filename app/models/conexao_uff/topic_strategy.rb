module ConexaoUff
  class TopicStrategy
    include HTTParty
    #API_URL = 'http://homologacao.sti.uff.br/conexaouff/api/v1/'
    API_URL = 'http://localhost:3001/api/v1/'

    def initialize(params)
      @params = params
      @answers_formatter = AnswersFormatter.new
    end

    def all
      response = fetch("/topicos")
      if response[:code] == 200
        response[:body] = JSON.parse(response[:body]).map { |topic| format_topic topic }
      else
        response[:body] = { message: response[:body] }
      end
      response
    end

    def find(id)
      response = fetch("/topicos/#{id}")
      if response[:code] == 200
        response[:body] = format_topic(JSON.parse(response[:body]))
      end
      response
    end

    private

      def format_topic(attributes)
        {
          id: "conexao_uff-#{attributes['id']}",
          system: "conexao_uff",
          system_id: attributes["id"],
          created_at: attributes["created_at"],
          updated_at: attributes['updated_at'],
          name: attributes['nome'],
          author: attributes['usuario']['nome'],
          course_id: "conexao_uff-#{attributes['grupo_id']}",
          answers: @answers_formatter.format(attributes['respostas'])
        }
      end

      def fetch(path)
        response = HTTParty.get(API_URL + path, { body: { por_anosemestre: '20151' }, headers: { 'AUTHORIZATION' => "Token token=#{@params[:token]}" } })

        { code: response.code, body: response.body }
      end
  end
end
