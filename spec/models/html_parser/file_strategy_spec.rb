require 'rails_helper'

RSpec.describe HtmlParser::FileStrategy, :type => :model do
  let(:html_url) { 'http://professor.com' }
  subject(:strategy) { HtmlParser::FileStrategy.new(url: html_url) }

  it 'initializes with options' do
    expect(strategy).to respond_to(:all)
  end

  before do
    file_path = File.expand_path('../../../support/template/html_parser.html', __FILE__)
    allow(HTTParty).to receive(:get).with(html_url).and_return(File.open file_path)
  end

  describe '#all' do
    it 'returns the code' do
      files = strategy.all
      expect(files[:code]).to eq 200
    end

    it 'returns bad request when url no provided' do
      allow(HTTParty).to receive(:get).with(nil).and_call_original
      files = HtmlParser::FileStrategy.new(url: nil).all
      expect(files[:code]).to eq 400
    end

    it 'lists all the files' do
        events = strategy.all
        first_event = events[:body].first
        expect(first_event[:id]).to eq "html_parser-#{html_url}-file-1"
        expect(first_event[:file_name]).to eq 'Lista de Exercicios'
        expect(first_event[:description]).to eq 'Lista de exercicios para a P1'
        expect(first_event[:content_type]).to eq 'txt'
        expect(first_event[:file_size]).to eq '500kb'
        expect(first_event[:download_url]).to eq 'http://professor.com/lista-1.txt'
        expect(first_event[:owner]).to eq 'Professor'

        second_event = events[:body].last
        expect(second_event[:id]).to eq "html_parser-#{html_url}-file-2"
        expect(second_event[:file_name]).to eq 'Lista de Exercicios 2'
        expect(second_event[:description]).to eq 'Lista de exercicios para a P2'
        expect(second_event[:content_type]).to eq 'pdf'
        expect(second_event[:file_size]).to eq '5mb'
        expect(second_event[:download_url]).to eq 'http://professor.com/lista-2.pdf'
        expect(second_event[:owner]).to eq 'Professor'
    end
  end

  describe '#find' do
    it 'returns the code' do
      file = strategy.find('file-1')
      expect(file[:code]).to eq 200
    end

    it 'returns the formatted file' do
      file = strategy.find('file-1')[:body]
      expect(file[:file_name]).to eq 'Lista de Exercicios'
      expect(file[:description]).to eq 'Lista de exercicios para a P1'
      expect(file[:content_type]).to eq 'txt'
      expect(file[:file_size]).to eq '500kb'
      expect(file[:download_url]).to eq 'http://professor.com/lista-1.txt'
      expect(file[:owner]).to eq 'Professor'
    end
  end
end
