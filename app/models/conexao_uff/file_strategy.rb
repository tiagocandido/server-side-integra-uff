module ConexaoUff
  class FileStrategy < BaseStrategy

    def initialize(params)
      @params = params
      @path = "/arquivos"
    end

    private

    def format(attributes)
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


  end
end
