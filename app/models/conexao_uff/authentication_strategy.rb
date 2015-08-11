module ConexaoUff
  class AuthenticationStrategy
    include HTTParty
    base_uri 'http://homologacao.sti.uff.br/portal'
    PATH_DE_LOGIN_DO_PORTAL = '/ws/autenticacoes/login.json'
    PATH_DE_LOGOUT_DO_PORTAL = '/ws/autenticacoes/logout.json'
    PATH_DE_CONSULTA_DO_PORTAL = '/ws/autenticacoes/consulta.json'

    def initialize(options)
      @options = options
    end

    def login
      body = { iduff: @options[:login], senha: @options[:password] }
      response = self.class.post(PATH_DE_LOGIN_DO_PORTAL, body: body)
      normalized_login_response deep_string_to_bool(response.parsed_response)
    end

    def logout
      response = self.class.get(PATH_DE_LOGOUT_DO_PORTAL, @options[:token])
      deep_string_to_bool(response).parsed_response
    end

    def validation(token)
      body = { token: token }
      response = self.class.get(PATH_DE_CONSULTA_DO_PORTAL, body: body)
      normalized_validation_response deep_string_to_bool(response.parsed_response)
    end

    private

    def deep_string_to_bool(hash)
      hash.each do |key, value|
        if value.is_a? Hash
          hash[key] = deep_string_to_bool(value)
        else
          if value == 'false'
            hash[key] = false
          elsif value == 'true'
            hash[key] = true
          end
        end
      end
      hash
    end

    def normalized_login_response(response)
      if response['autenticado']
        { json: { token: response['token_identificador'] }, status: :ok }
      else
        { json: {}, status: :unauthorized }
      end
    end

    def normalized_validation_response(response)
        { json: { valid: response['valido'] } }
    end
  end
end

