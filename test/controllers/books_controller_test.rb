require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books :hobbit
  end

  test 'should get index' do
    get books_url
    assert_response :success
  end

  test 'should get available' do
    get books_url(scope: 'available')
    assert_response :success
  end

  test 'should get borrowed' do
    get books_url(scope: 'borrowed')
    assert_response :success
  end

  test 'should get delayed' do
    get books_url(scope: 'delayed')
    assert_response :success
  end

  test 'should get new' do
    get new_book_url
    assert_response :success
  end

  test 'should create book' do
    assert_difference 'Book.count' do
      post books_url, params: { book: {
          title:       'The New One',
          author:      '<unknown>',
          released_on: Date.today,
          category_id: categories(:history).id,
      } }
    end

    assert_redirected_to book_url(Book.last)
  end

  test 'should show book' do
    get book_url(@book)
    assert_response :success
  end

  test 'should get edit' do
    get edit_book_url(@book)
    assert_response :success
  end

  test 'should update book' do
    new_category = categories :history

    patch book_url(@book), params: { book: {
        category_id: new_category.id
    } }

    assert_redirected_to book_url(@book)

    @book.reload

    assert_equal new_category, @book.category
  end

  test 'should destroy book' do
    assert_difference 'Book.count', -1 do
      delete book_url(@book)
    end

    assert_redirected_to books_url
  end
end
