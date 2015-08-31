module ConexaoUff
  class FileStrategy
    include HTTParty
    #API_URL = 'http://homologacao.sti.uff.br/conexaouff/api/v1/'
    API_URL = 'http://localhost:3001/api/v1/'

    def initialize(params)
      @params = params
    end

    def all
      response = fetch("/arquivos")
      if response[:code] == 200
        response[:body] = JSON.parse(response[:body]).map { |file| format_file file }
      else
        response[:body] = { message: response[:body] }
      end
      response
    end

    def find(id)
      response = fetch("/arquivos/#{id}")
      if response[:code] == 200
        response[:body] = format_event(JSON.parse(response[:body]))
      end
      response
    end

    private

    def format_file(attributes)
      {
          id: "conexao_uff-#{attributes['id']}",
          system: "conexao_uff",
          system_id: attributes["id"],
          description: attributes["descricao"],
          course_id: attributes["grupo_id"],
          file_name: attributes["anexo_file_name"],
          content_type: attributes["anexo_content_type"],
          file_size: attributes["anexo_file_size"],
          download_url: attributes["download_url"],
          created_at: attributes["created_at"],
          updated_at: attributes["anexo_updated_at"]
      }
    end

    def fetch(path)
      response = HTTParty.get(API_URL + path, { headers: { 'AUTHORIZATION' => "Token token=#{@params[:token]}" } })

      { code: response.code, body: response.body }
    end
  end
end
