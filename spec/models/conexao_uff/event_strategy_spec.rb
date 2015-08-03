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
    it 'should list the events' do
        expect(events.first).to have_key(:system)
        expect(events.first).to have_key(:system_id)
        expect(events.first).to have_key(:name)
        expect(events.first).to have_key(:info)
    end
  end

  describe '#find' do
    let(:event) do
      VCR.use_cassette('model/event') { strategy.find(events.first[:system_id]) }
    end

    it 'should find an event' do
      expect(event).to have_key(:system)
      expect(event).to have_key(:system_id)
      expect(event).to have_key(:starts)
      expect(event).to have_key(:ends)
      expect(event).to have_key(:name)
      expect(event).to have_key(:info)
      expect(event).to have_key(:course_id)
    end
  end

end
