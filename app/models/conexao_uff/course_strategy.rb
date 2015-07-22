module ConexaoUff
  class CourseStrategy
    include HTTParty
    #API_URL = 'http://homologacao.sti.uff.br/conexaouff/api/v1/'
    API_URL = 'http://localhost:3001/api/v1/'

    def initialize(params)
      @params = params
    end

    def all
      courses = fetch('/grupos')
      courses.map { |course| format course }
    end

    def find(id)
      course = fetch("/grupos/#{id}")
      format(course)
    end

    private

    def format(attributes)
      {
        system: 'conexao_uff',
        system_id: attributes['id'],
        name: "#{attributes['nome']} - #{attributes['anosemestre']}",
        info: attributes['descricao']
      }
    end

    def fetch(path)
      response = HTTParty.get(API_URL + path, { body: {por_anosemestres: '20151'} , headers: { 'AUTHORIZATION' => "Token token=#{@params[:token]}" }})
      JSON.parse(response.body)
    end
  end
end
