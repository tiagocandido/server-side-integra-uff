class AuthenticationAdapter

  def initialize(platform, options = {})
    set_strategy platform, options
  end

  def login
    @strategy.login
  end

  def validation(token)
    @strategy.validation token
  end

  def logout(token)
    @strategy.logout token
  end

  private

    def set_strategy(platform, options)
      @strategy ||= platform.camelize.constantize::AuthenticationStrategy.new(options)
    end
end
