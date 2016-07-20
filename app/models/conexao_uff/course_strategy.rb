module ConexaoUff
  class CourseStrategy < BaseStrategy

    def initialize(params)
      @params = params
    end

    def all
      response = fetch('/grupos', true)
      if response[:code] == 200
        response[:body] = JSON.parse(response[:body]).map { |course| format_course course }
      else
        response[:body] = { message: response[:body] }
      end
      response
    end

    def find(id)
      response = fetch("/grupos/#{id}", true)
      if response[:code] == 200
        response[:body] = format_course(JSON.parse(response[:body]))
      end
      response
    end

    private

    def format_course(attributes)
      {
        id: "conexao_uff-#{attributes['id']}",
        system: 'conexao_uff',
        system_id: attributes['id'],
        name: "#{attributes['nome']} - #{attributes['anosemestre']}",
        info: attributes['descricao']
      }
    end
  end
end
