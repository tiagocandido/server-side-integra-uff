module ConexaoUff
  class CourseStrategy
    include HTTParty
    #API_URL = 'http://homologacao.sti.uff.br/conexaouff/api/v1/'
    API_URL = 'http://localhost:3001/api/v1/'

    def initialize(params)
      @params = params
    end

    def all
      response = fetch('/grupos')
      if response[:code] == 200
        response[:body] = JSON.parse(response[:body]).map { |course| format_course course }
      end
      response
    end

    def find(id)
      response = fetch("/grupos/#{id}")
      if response[:code] == 200
        response[:body] = format_course(JSON.parse(response[:body]))
      end
      response
    end

    private

    def format_course(attributes)
      {
        system: 'conexao_uff',
        system_id: attributes['id'],
        name: "#{attributes['nome']} - #{attributes['anosemestre']}",
        info: attributes['descricao']
      }
    end

    def fetch(path)
      response = HTTParty.get(API_URL + path, { body: {por_anosemestres: '20151'} , headers: { 'AUTHORIZATION' => "Token token=#{@params[:token]}" }})

      { code: response.code, body: response.body }
    end
  end
end
