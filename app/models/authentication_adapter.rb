class AuthenticationAdapter

  def initialize(platform, options = {})
    set_strategy(platform, options)
  end

  def login
    @strategy.login
  end

  def logout
    @strategy.logout
  end

  private

    def set_strategy(platform, options)
      @strategy ||= platform.camelize.constantize::AuthenticationStrategy.new(options)
    end
end