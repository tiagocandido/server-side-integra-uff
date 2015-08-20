module ConexaoUff
  class AnswersFormatter
    def format(answers)
      answers.map { |attributes| format_answer(attributes) }
    end

    private

    def format_answer(attributes)
      {
          id: "conexao_uff-#{attributes['id']}",
          system: "conexao_uff",
          system_id: attributes["id"],
          updated_at: attributes['updated_at'],
          content: attributes['corpo'],
          author: attributes['usuario']['nome'],
          topic_id: "conexao_uff-#{attributes['topico_id']}",
      }
    end
  end
end
