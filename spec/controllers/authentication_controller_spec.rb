require 'rails_helper'

RSpec.describe AuthenticationController, :type => :controller do

  before(:each) do
    @adapter = double('AuthenticationAdapter', login: { json: {}, status: 200 } )
    allow(AuthenticationAdapter).to receive(:new).and_return(@adapter)
  end

  describe "GET login" do
    it "should call login on adapter" do
      expect(@adapter).to receive(:login)
      get :login, { system: 'system' }

      expect(response.body).to eq '{}'
      expect(response.status).to eq 200
    end
  end
end
