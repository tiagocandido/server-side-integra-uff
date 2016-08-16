module ConexaoUff
  class CourseStrategy < BaseStrategy

    def initialize(params)
      @params = params
      @path = "/grupos"
      @fetch_options = { body: {por_anosemestres: ConexaoUff::ANO_SEMESTRE} }
    end

    private

    def format(attributes)
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
