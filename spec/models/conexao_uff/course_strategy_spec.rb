require 'rails_helper'

RSpec.describe ConexaoUff::CourseStrategy, :type => :model do
  subject(:strategy) { ConexaoUff::CourseStrategy.new(token: '') }

  it 'should initialize with options' do
    options = {}
    strategy = ConexaoUff::CourseStrategy.new options
    expect(strategy).to respond_to(:all)
  end

  let!(:courses) do
    VCR.use_cassette('model/courses') { strategy.all }
  end

  describe '#all' do
    it 'should return the code' do
      expect(courses[:code]).to eq 200
    end

    it 'should list the courses' do
      first_course = courses[:body].first

      expect(first_course[:id]).to eq 'conexao_uff-77947'
      expect(first_course).to have_key(:system)
      expect(first_course).to have_key(:system_id)
      expect(first_course).to have_key(:name)
      expect(first_course).to have_key(:info)
    end
  end

  describe '#find' do
    let(:course) do
      VCR.use_cassette('model/course') { strategy.find(courses[:body].first[:system_id]) }
    end

    it 'should return the code' do
      expect(course[:code]).to eq 200
    end

    it 'should find a courses' do
      expect(course[:body][:id]).to eq 'conexao_uff-77947'
      expect(course[:body]).to have_key(:system)
      expect(course[:body]).to have_key(:system_id)
      expect(course[:body]).to have_key(:name)
      expect(course[:body]).to have_key(:info)
    end
  end
end
