require 'rails_helper'

RSpec.describe ConexaoUff::EventStrategy, :type => :model do
  subject(:strategy) { ConexaoUff::EventStrategy.new(token: '') }

  it 'should initialize with options' do
    expect(strategy).to respond_to(:all)
  end

  let!(:events) do
    VCR.use_cassette('model/events') { strategy.all }
  end

  describe '#all' do
    it 'should return the code' do
      expect(events[:code]).to eq 200
    end

    it 'should list the events' do
        first_event = events[:body].first
        expect(first_event[:id]).to eq 'conexao_uff-1729'
        expect(first_event).to have_key(:system)
        expect(first_event).to have_key(:system_id)
        expect(first_event).to have_key(:name)
        expect(first_event).to have_key(:info)
    end
  end

  describe '#find' do
    let(:event) do
      VCR.use_cassette('model/event') { strategy.find(events[:body].first[:system_id]) }
    end

    it 'should return the code' do
      expect(event[:code]).to eq 200
    end

    it 'should find an event' do
      expect(event[:body][:id]).to eq 'conexao_uff-1729'
      expect(event[:body]).to have_key(:system)
      expect(event[:body]).to have_key(:system_id)
      expect(event[:body]).to have_key(:starts)
      expect(event[:body]).to have_key(:ends)
      expect(event[:body]).to have_key(:name)
      expect(event[:body]).to have_key(:info)
      expect(event[:body]).to have_key(:course_id)
    end
  end

end
