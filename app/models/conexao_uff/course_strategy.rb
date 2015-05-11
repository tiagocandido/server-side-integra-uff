module ConexaoUff
  class CourseStrategy
    include HTTParty
    API_URL = 'http://homologacao.sti.uff.br/conexaouff/api/v1/'

    def all
      courses = fetch('/grupos')
      courses.map { |course| format course }
    end

    def find(id)
      course = fetch('/grupos/' + id)
      format(course)
    end

    private

      def format(attributes)
        { system: "conexao_uff",
          system_id: attributes["id"],
          name: "#{attributes["nome"]} - #{attributes["anosemestre"]}",
          info: attributes['descricao']
        }
      end

      def fetch(path)
        response = HTTParty.get(API_URL + path)
        JSON.parse(response.body)
      end
  end
end
