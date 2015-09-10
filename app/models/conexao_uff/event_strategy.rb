module ConexaoUff
  class EventStrategy
    include HTTParty

    def initialize(params)
      @params = params
    end

    def all
      response = fetch("/eventos")
      if response[:code] == 200
        response[:body] = JSON.parse(response[:body]).map { |event| format_event event }
      else
        response[:body] = { message: response[:body] }
      end
      response
    end

    def find(id)
      response = fetch("/eventos/#{id}")
      if response[:code] == 200
        response[:body] = format_event(JSON.parse(response[:body]))
      end
      response
    end

    private

      def format_event(attributes)
        {
          id: "conexao_uff-#{attributes['id']}",
          system: "conexao_uff",
          system_id: attributes["id"],
          starts: attributes["inicio"],
          ends: attributes['fim'],
          name: attributes['titulo'],
          info: attributes['info'],
          course_id: "conexao_uff-#{attributes['grupo_id']}"
        }
      end

      def fetch(path)
        scopes = {}
        scopes = { atualizado_desde: @params[:last_sync] }  if @params.key? :last_sync

        response = HTTParty.get(ConexaoUff::API_URL + path, { body: scopes, headers: { 'AUTHORIZATION' => "Token token=#{@params[:token]}" } })

        { code: response.code, body: response.body }
      end
  end
end
