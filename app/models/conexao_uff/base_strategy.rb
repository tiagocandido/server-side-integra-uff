module ConexaoUff
  class BaseStrategy
    include HTTParty

    private

    def fetch(path, with_year = false)
      options = { headers: { 'AUTHORIZATION' => "Token token=#{@params[:token]}" } }
      year_options = { body: {por_anosemestres: '20151'} }

      options.merge year_options if with_year

      response = HTTParty.get(ConexaoUff::API_URL + path, { headers: { 'AUTHORIZATION' => "Token token=#{@params[:token]}" } })

      { code: response.code, body: response.body }
    end
  end
end
