require 'rails_helper'

RSpec.describe ConexaoUff::EventStrategy, :type => :model do
  subject(:strategy) { ConexaoUff::EventStrategy.new(token: '') }

  it 'should initialize with options' do
    expect(strategy).to respond_to(:all)
  end

  describe '#all' do
    it 'should list the events' do
      VCR.use_cassette 'model/events' do
        events = strategy.all
        expect(events.first).to have_key(:system)
        expect(events.first).to have_key(:system_id)
        expect(events.first).to have_key(:name)
        expect(events.first).to have_key(:info)
      end
    end
  end

  describe '#find' do
    it 'should find an event' do
      events = VCR.use_cassette 'model/events' do
        strategy.all
      end
      VCR.use_cassette 'model/event' do
        event = strategy.find(events.first[:system_id])
        expect(event).to have_key(:system)
        expect(event).to have_key(:system_id)
        expect(event).to have_key(:starts)
        expect(event).to have_key(:ends)
        expect(event).to have_key(:name)
        expect(event).to have_key(:info)
        expect(event).to have_key(:group_id)
      end
    end
  end

end
