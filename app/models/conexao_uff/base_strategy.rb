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

    def fetch(path)
      options = { headers: { 'AUTHORIZATION' => "Token token=#{@params[:token]}" } }

      options.merge @fetch_options if @fetch_options

      response = HTTParty.get(ConexaoUff::API_URL + path, { headers: { 'AUTHORIZATION' => "Token token=#{@params[:token]}" } })

      { code: response.code, body: response.body }
    end
  end
end
