module ConexaoUff
  class EventStrategy < BaseStrategy

    def initialize(params)
      @params = params
      @path = "/eventos"
    end

    private

      def format(attributes)
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
  end
end
