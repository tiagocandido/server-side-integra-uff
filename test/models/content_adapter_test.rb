require 'test_helper'

class ContentAdapterTest < ActiveSupport::TestCase
  test "collection should call all on strategy" do
    strategy = MiniTest::Mock.new
    strategy.expect(:all, true)
    content_adapter =  ContentAdapter.new(strategy)

    assert content_adapter.collection
  end

  test "member should call find on strategy" do
    strategy = MiniTest::Mock.new
    strategy.expect(:find, true, [1])
    content_adapter =  ContentAdapter.new(strategy)

    assert content_adapter.member(1)
  end
end
