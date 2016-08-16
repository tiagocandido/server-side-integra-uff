require 'rails_helper'

RSpec.describe EventAdapter, :type => :model do
  subject(:adapter) { EventAdapter.new('ConexaoUff') }

  describe '#set_strategy' do
    it 'returns a the correct platform event strategy' do
      expect(adapter.set_strategy('ConexaoUff', {})).to be_an_instance_of(ConexaoUff::EventStrategy)
    end
  end

  describe '#collection' do
    before do
      allow_any_instance_of(ConexaoUff::EventStrategy).to receive(:all).and_return('All Events')
    end

    it 'returns all events from the platform' do
      expect(adapter.collection).to eq 'All Events'
    end
  end

  describe '#member' do
    before do
      allow_any_instance_of(ConexaoUff::EventStrategy).to receive(:find).with(1).and_return('Event')
    end

    it 'returns a specfic event from the platform' do
      expect(adapter.member(1)).to eq 'Event'
    end
  end
end
