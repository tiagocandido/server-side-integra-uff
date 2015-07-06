class AuthenticationController < ApplicationController
  before_filter :set_adapter

  def login
    render @authentication.login
  end

  private

  def set_adapter
    @authentication = AuthenticationAdapter.new(params[:system], { login: params[:login], password: params[:password] })
  end
end
