require 'rails_helper'

RSpec.describe TopicsController, :type => :controller do

  before(:each) do
    fake_response = { code: 201, body: 'body' }
    @adapter = double('TopicAdapter', collection: fake_response, member: fake_response)
    allow(TopicAdapter).to receive(:new).and_return(@adapter)
  end

  describe "GET index" do
    it "should call collection on adapter" do
      expect(@adapter).to receive(:collection)
      get :index, { system: 'system' }

      expect(response.body).to eq 'body'
      expect(response.status).to eq 201
    end
  end

  describe "GET show" do
    it "should call member with id on adapter" do
      expect(@adapter).to receive(:member).with("1")
      get :show, { id: 1, system: 'system' }

      expect(response.body).to eq 'body'
      expect(response.status).to eq 201
    end
  end
end
