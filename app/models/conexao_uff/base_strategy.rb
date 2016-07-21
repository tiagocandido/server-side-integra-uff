module ConexaoUff
  class BaseStrategy
    include HTTParty

    def all
      response = fetch(@path)
      if response[:code] == 200
        response[:body] = JSON.parse(response[:body]).map { |resource| format resource }
      else
        response[:body] = { message: response[:body] }
      end
      response
    end

    def find(id)
      response = fetch("#{@path}/#{id}")
      if response[:code] == 200
        response[:body] = format(JSON.parse(response[:body]))
      end
      response
    end

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
