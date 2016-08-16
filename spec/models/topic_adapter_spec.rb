require 'rails_helper'

RSpec.describe TopicAdapter, :type => :model do
  subject(:adapter) { TopicAdapter.new('ConexaoUff') }

  describe '#set_strategy' do
    it 'returns a the correct platform topic strategy' do
      expect(adapter.set_strategy('ConexaoUff', {})).to be_an_instance_of(ConexaoUff::TopicStrategy)
    end
  end

  describe '#collection' do
    before do
      allow_any_instance_of(ConexaoUff::TopicStrategy).to receive(:all).and_return('All Topics')
    end

    it 'returns all topics from the platform' do
      expect(adapter.collection).to eq 'All Topics'
    end
  end

  describe '#member' do
    before do
      allow_any_instance_of(ConexaoUff::TopicStrategy).to receive(:find).with(1).and_return('Topic')
    end

    it 'returns a specfic topic from the platform' do
      expect(adapter.member(1)).to eq 'Topic'
    end
  end
end
