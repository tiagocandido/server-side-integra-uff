module ConexaoUff
  class FileStrategy
    include HTTParty

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
          course_id: "conexao_uff-#{attributes['grupo_id']}",
          owner: attributes['usuario_nome'],
          file_name: attributes["anexo_file_name"],
          content_type: attributes["anexo_content_type"],
          file_size: attributes["anexo_file_size"],
          download_url: attributes["download_url"],
          created_at: attributes["created_at"],
          updated_at: attributes["anexo_updated_at"]
      }
    end

    def fetch(path)
      scopes = {}
      scopes = { atualizado_desde: @params[:last_sync] }  if @params.key? :last_sync
      response = HTTParty.get(ConexaoUff::API_URL + path, { body: scopes,  headers: { 'AUTHORIZATION' => "Token token=#{@params[:token]}" } })

      { code: response.code, body: response.body }
    end
  end
end
