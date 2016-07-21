module ConexaoUff
  class TopicStrategy < BaseStrategy

    def initialize(params)
      @params = params
      @answers_formatter = AnswersFormatter.new
      @path = "/topicos"
      @fetch_options = { body: {por_anosemestres: ConexaoUff::ANO_SEMESTRE} }
    end

    private

      def format(attributes)
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
  end
end
