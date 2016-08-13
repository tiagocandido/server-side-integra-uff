require 'rails_helper'

RSpec.describe ConexaoUff::TopicStrategy, :type => :model do
  subject(:strategy) { ConexaoUff::TopicStrategy.new(token: '') }

  it 'should initialize with options' do
    expect(strategy).to respond_to(:all)
  end

  let!(:topics) do
    VCR.use_cassette('model/topics') { strategy.all }
  end

  describe '#all' do
    it 'should return the code' do
      expect(topics[:code]).to eq 200
    end

    it 'should list the topics' do
      first_topic = topics[:body].first
      expect(first_topic[:id]).to eq 'conexao_uff-2990'
      expect(first_topic).to have_key(:system)
      expect(first_topic).to have_key(:system_id)
      expect(first_topic).to have_key(:name)
      expect(first_topic).to have_key(:author)
      expect(first_topic).to have_key(:course_id)
      expect(first_topic).to have_key(:answers)
    end
  end

  describe '#find' do
    let(:topic) do
      VCR.use_cassette('model/topic') { strategy.find(topics[:body].first[:system_id]) }
    end

    it 'should return the code' do
      expect(topic[:code]).to eq 200
    end

    it 'should find an topic' do
      expect(topic[:body][:id]).to eq 'conexao_uff-2990'
      expect(topic[:body]).to have_key(:system)
      expect(topic[:body]).to have_key(:system_id)
      expect(topic[:body]).to have_key(:name)
      expect(topic[:body]).to have_key(:author)
      expect(topic[:body]).to have_key(:course_id)
      expect(topic[:body]).to have_key(:answers)
    end
  end

end
