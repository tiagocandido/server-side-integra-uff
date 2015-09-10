module ConexaoUff
  class CourseStrategy
    include HTTParty

    def initialize(params)
      @params = params
    end

    def all
      response = fetch('/grupos')
      if response[:code] == 200
        response[:body] = JSON.parse(response[:body]).map { |course| format_course course }
      else
        response[:body] = { message: response[:body] }
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
        id: "conexao_uff-#{attributes['id']}",
        system: 'conexao_uff',
        system_id: attributes['id'],
        name: "#{attributes['nome']} - #{attributes['anosemestre']}",
        info: attributes['descricao']
      }
    end

    def fetch(path)
      scopes =  {por_anosemestres: '20151'}
      scopes[:atualizado_desde] = @params[:last_sync] if @params.key? :last_sync
      response = HTTParty.get(ConexaoUff::API_URL + path, { body: scopes , headers: { 'AUTHORIZATION' => "Token token=#{@params[:token]}" }})

      { code: response.code, body: response.body }
    end
  end
end
