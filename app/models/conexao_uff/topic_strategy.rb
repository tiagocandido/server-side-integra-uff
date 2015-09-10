module ConexaoUff
  class TopicStrategy
    include HTTParty

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
        scopes =  {por_anosemestres: '20151'}
        scopes[:atualizado_desde] = @params[:last_sync] if @params.key? :last_sync
        response = HTTParty.get(ConexaoUff::API_URL + path, { body: scopes, headers: { 'AUTHORIZATION' => "Token token=#{@params[:token]}" } })

        { code: response.code, body: response.body }
      end
  end
end
