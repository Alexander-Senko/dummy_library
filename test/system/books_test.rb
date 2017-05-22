require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  test 'visiting the index' do
    visit books_url

    assert_selector 'h1', text: 'Books'
  end

  test 'librarian can list all books alphabetically' do
    flunk # TODO
  end

  test 'librarian can filter books by category' do
    visit books_path(category_id: categories(:history).id)

    assert_no_text categories(:adventure).name
    assert_no_text categories(:science).name
  end

  test 'librarian can see what books are available' do
    visit books_url(scope: 'available')

    assert_text    books(:hobbit).title
    assert_no_text books(:magic_guide).title
    assert_text    books(:history_of_mordor).title
  end

  test 'librarian can see what books are borrowed out' do
    visit books_url(scope: 'borrowed')

    assert_no_text books(:hobbit).title
    assert_text    books(:magic_guide).title
    assert_no_text books(:history_of_mordor).title
  end

  test 'librarian can see what books are delayed' do
    travel_to Date.new(3017, 7, 1) do
      visit books_url(scope: 'delayed')

      assert_no_text books(:hobbit).title
      assert_no_text books(:magic_guide).title
      assert_no_text books(:history_of_mordor).title
    end

    travel_to Date.new(3017, 8, 1) do
      visit books_url(scope: 'delayed')

      assert_no_text books(:hobbit).title
      assert_no_text books(:magic_guide).title
      assert_no_text books(:history_of_mordor).title
    end

    travel_to Date.new(3017, 9, 1) do
      visit books_url(scope: 'delayed')

      assert_no_text books(:hobbit).title
      assert_text    books(:magic_guide).title
      assert_no_text books(:history_of_mordor).title
    end

    travel_to Date.new(3019, 5, 1) do
      visit books_url(scope: 'delayed')

      assert_no_text books(:hobbit).title
      assert_text    books(:magic_guide).title
      assert_no_text books(:history_of_mordor).title
    end
  end

  test 'librarian can add a new book' do
    visit books_path

    click_on 'New Book'

    # TODO: figure out why form controls' IDs are missing. Looks like a bug in Rails
    fill_in 'Title',       with: 'Creating a Book'
    fill_in 'Author',      with: 'The Tester'
    fill_in 'Released on', with: Date.today
    fill_in 'Category',    with: 'Science'

    click_on 'Create Book'

    assert_text 'Creating a Book'
  end

  test 'librarian can edit a book' do
    flunk # TODO
  end
end
