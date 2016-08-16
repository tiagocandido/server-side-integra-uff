require 'rails_helper'

RSpec.describe ConexaoUff::FileStrategy, :type => :model do
  subject(:strategy) { ConexaoUff::FileStrategy.new(token: '') }

  it 'should initialize with options' do
    expect(strategy).to respond_to(:all)
  end

  let!(:files) do
    VCR.use_cassette('model/files') { strategy.all }
  end

  describe '#all' do
    it 'should return the code' do
      expect(files[:code]).to eq 200
    end

    it 'should list the files' do
      first_file = files[:body].first
      expect(first_file[:id]).to eq 'conexao_uff-216'
      expect(first_file).to have_key(:system)
      expect(first_file).to have_key(:system_id)
      expect(first_file).to have_key(:description)
      expect(first_file).to have_key(:course_id)
      expect(first_file).to have_key(:owner)
      expect(first_file).to have_key(:file_name)
      expect(first_file).to have_key(:content_type)
      expect(first_file).to have_key(:file_size)
      expect(first_file).to have_key(:download_url)
      expect(first_file).to have_key(:created_at)
    end
  end

  describe '#find' do
    let(:file) do
      VCR.use_cassette('model/file') { strategy.find(files[:body].first[:system_id]) }
    end

    it 'should return the code' do
      expect(file[:code]).to eq 200
    end

    it 'should find an file' do
      expect(file[:body][:id]).to eq 'conexao_uff-216'
      expect(file[:body]).to have_key(:system)
      expect(file[:body]).to have_key(:system_id)
      expect(file[:body]).to have_key(:description)
      expect(file[:body]).to have_key(:course_id)
      expect(file[:body]).to have_key(:owner)
      expect(file[:body]).to have_key(:file_name)
      expect(file[:body]).to have_key(:content_type)
      expect(file[:body]).to have_key(:file_size)
      expect(file[:body]).to have_key(:download_url)
      expect(file[:body]).to have_key(:created_at)
    end
  end

end
