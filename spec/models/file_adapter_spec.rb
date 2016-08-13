require 'rails_helper'

RSpec.describe FileAdapter, :type => :model do
  subject(:adapter) { FileAdapter.new('ConexaoUff') }

  describe '#set_strategy' do
    it 'returns a the correct platform file strategy' do
      expect(adapter.set_strategy('ConexaoUff', {})).to be_an_instance_of(ConexaoUff::FileStrategy)
    end
  end

  describe '#collection' do
    before do
      allow_any_instance_of(ConexaoUff::FileStrategy).to receive(:all).and_return('All Files')
    end

    it 'returns all files from the platform' do
      expect(adapter.collection).to eq 'All Files'
    end
  end

  describe '#member' do
    before do
      allow_any_instance_of(ConexaoUff::FileStrategy).to receive(:find).with(1).and_return('File')
    end

    it 'returns a specfic file from the platform' do
      expect(adapter.member(1)).to eq 'File'
    end
  end
end
