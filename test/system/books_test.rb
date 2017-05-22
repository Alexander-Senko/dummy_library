require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  test 'visiting the index' do
    visit books_url

    assert_selector 'h1', text: 'Books'
  end

  test 'librarian can add a new book' do
    visit books_path

    click_on 'New Book'

    fill_in 'Title',       with: 'Creating a Book'
    fill_in 'Author',      with: 'The Tester'
    fill_in 'Released on', with: Date.today
    fill_in 'Category',    with: 'Science'

    click_on 'Create Book'

    assert_text 'Creating a Book'
  end

  test 'librarian can edit a book' do
    # TODO
  end

  test 'librarian can list all books alphabetically' do
    # TODO
  end

  test 'librarian can filter books by category' do
    visit books_path(category_id: categories(:history).id)

    assert_no_text categories(:adventure).name
    assert_no_text categories(:science).name
  end
end
