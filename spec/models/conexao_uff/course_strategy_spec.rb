require 'rails_helper'

RSpec.describe ConexaoUff::CourseStrategy, :type => :model do
  it 'should initialize with options' do
    options = {}
    strategy = ConexaoUff::CourseStrategy.new options
    expect(strategy).to respond_to(:all)
  end

  it 'should list the courses' do
    VCR.use_cassette 'model/courses' do
      courses = ConexaoUff::CourseStrategy.new({token: 'banana'}).all
      expect(courses.first).to have_key(:system)
      expect(courses.first).to have_key(:system_id)
      expect(courses.first).to have_key(:name)
      expect(courses.first).to have_key(:info)
    end
  end

  it 'should find a courses' do
    courses = VCR.use_cassette 'model/courses' do
      ConexaoUff::CourseStrategy.new({token: 'banana'}).all
    end
    VCR.use_cassette 'model/course' do
      course = ConexaoUff::CourseStrategy.new({token: 'banana'}).find(courses.first[:system_id])
      expect(course).to have_key(:system)
      expect(course).to have_key(:system_id)
      expect(course).to have_key(:name)
      expect(course).to have_key(:info)
    end
  end
end