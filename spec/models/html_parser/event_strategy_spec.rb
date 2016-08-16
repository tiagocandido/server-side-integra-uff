require 'rails_helper'

RSpec.describe HtmlParser::EventStrategy, :type => :model do
  let(:html_url) { 'http://professor.com' }
  subject(:strategy) { HtmlParser::EventStrategy.new(url: html_url) }

  it 'initializes with options' do
    expect(strategy).to respond_to(:all)
  end

  before do
    file_path = File.expand_path('../../../support/template/html_parser.html', __FILE__)
    allow(HTTParty).to receive(:get).with(html_url).and_return(File.open file_path)
  end

  describe '#all' do
    it 'returns the code' do
      events = strategy.all
      expect(events[:code]).to eq 200
    end

    it 'returns bad request when url no provided' do
      allow(HTTParty).to receive(:get).with(nil).and_call_original
      files = HtmlParser::EventStrategy.new(url: nil).all
      expect(files[:code]).to eq 400
    end

    it 'lists the events' do
        events = strategy.all
        first_event = events[:body].first
        expect(first_event[:id]).to eq "html_parser-#{html_url}-event-1"
        expect(first_event[:name]).to eq 'Entrega do Trabalho Final'
        expect(first_event[:starts]).to eq '10/08/2016 - 11:00'
        expect(first_event[:ends]).to eq '10/08/2016 - 13:00'
        expect(first_event[:info]).to eq 'Info 1'
        expect(first_event[:system_id]).to eq 'event-1'

        second_event = events[:body].last
        expect(second_event[:id]).to eq "html_parser-#{html_url}-event-2"
        expect(second_event[:name]).to eq 'Prova 2'
        expect(second_event[:starts]).to eq '13/08/2016 - 11:00'
        expect(second_event[:ends]).to eq '13/08/2016 - 13:00'
        expect(second_event[:info]).to eq 'Materia da Prova'
        expect(second_event[:system_id]).to eq 'event-2'
    end
  end

  describe '#find' do
    it 'returns the code' do
      event = strategy.find('event-1')
      expect(event[:code]).to eq 200
    end

    it 'returns the formatted event' do
      event = strategy.find('event-1')[:body]
      expect(event[:id]).to eq "html_parser-#{html_url}-event-1"
      expect(event[:name]).to eq 'Entrega do Trabalho Final'
      expect(event[:starts]).to eq '10/08/2016 - 11:00'
      expect(event[:ends]).to eq '10/08/2016 - 13:00'
      expect(event[:info]).to eq 'Info 1'
      expect(event[:system_id]).to eq 'event-1'
    end
  end
end
