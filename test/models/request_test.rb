require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  test 'active' do
    assert_not_includes Request.active, requests(:gandalf)
    assert_includes     Request.active, requests(:smeagol)
  end

  test 'expired' do
    travel_to Date.new(3017, 7, 1) do
      assert_not_includes Request.expired, requests(:gandalf)
      assert_not_includes Request.expired, requests(:smeagol)
    end

    travel_to Date.new(3017, 8, 1) do
      assert_not_includes Request.expired, requests(:gandalf)
      assert_not_includes Request.expired, requests(:smeagol)
    end

    travel_to Date.new(3017, 9, 1) do
      assert_not_includes Request.expired, requests(:gandalf)
      assert_includes     Request.expired, requests(:smeagol)
    end

    travel_to Date.new(3019, 5, 1) do
      assert_not_includes Request.expired, requests(:gandalf)
      assert_includes     Request.expired, requests(:smeagol)
    end
  end

  test 'active_requests' do
    flunk # TODO
  end

  test 'expired_requests' do
    flunk # TODO
  end
end
