require 'test_helper'

class BookTest < ActiveSupport::TestCase
  test 'available' do
    assert_includes     Book.available, books(:hobbit)
    assert_not_includes Book.available, books(:magic_guide)
    assert_includes     Book.available, books(:history_of_mordor)
  end

  test 'borrowed' do
    assert_not_includes Book.borrowed, books(:hobbit)
    assert_includes     Book.borrowed, books(:magic_guide)
    assert_not_includes Book.borrowed, books(:history_of_mordor)
  end

  test 'delayed' do
    travel_to Date.new(3017, 7, 1) do
      assert_not_includes Book.delayed, books(:hobbit)
      assert_not_includes Book.delayed, books(:magic_guide)
      assert_not_includes Book.delayed, books(:history_of_mordor)
    end

    travel_to Date.new(3017, 8, 1) do
      assert_not_includes Book.delayed, books(:hobbit)
      assert_not_includes Book.delayed, books(:magic_guide)
      assert_not_includes Book.delayed, books(:history_of_mordor)
    end

    travel_to Date.new(3017, 9, 1) do
      assert_not_includes Book.delayed, books(:hobbit)
      assert_includes     Book.delayed, books(:magic_guide)
      assert_not_includes Book.delayed, books(:history_of_mordor)
    end

    travel_to Date.new(3019, 5, 1) do
      assert_not_includes Book.delayed, books(:hobbit)
      assert_includes     Book.delayed, books(:magic_guide)
      assert_not_includes Book.delayed, books(:history_of_mordor)
    end
  end
end
