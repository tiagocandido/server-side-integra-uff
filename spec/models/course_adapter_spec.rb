require 'rails_helper'

RSpec.describe CourseAdapter, :type => :model do
  subject(:adapter) { CourseAdapter.new('ConexaoUff') }

  describe '#set_strategy' do
    it 'returns a the correct platform course strategy' do
      expect(adapter.set_strategy('ConexaoUff', {})).to be_an_instance_of(ConexaoUff::CourseStrategy)
    end
  end

  describe '#collection' do
    before do
      allow_any_instance_of(ConexaoUff::CourseStrategy).to receive(:all).and_return('All Courses')
    end

    it 'returns all courses from the platform' do
      expect(adapter.collection).to eq 'All Courses'
    end
  end

  describe '#member' do
    before do
      allow_any_instance_of(ConexaoUff::CourseStrategy).to receive(:find).with(1).and_return('Course')
    end

    it 'returns a specfic course from the platform' do
      expect(adapter.member(1)).to eq 'Course'
    end
  end
end
