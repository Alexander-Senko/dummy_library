require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book         = books    :hobbit
    @book_request = requests :smeagol
  end

  test 'should get index' do
    get requests_url
    assert_response :success
  end

  test 'should get new' do
    get new_book_request_url(@book)
    assert_response :success
  end

  test 'should create request' do
    assert_difference 'Request.count' do
      post book_requests_url(@book), params: { request: {
          borrower:         'Frodo Baggins',
          borrowed_on:      Date.today,
          should_return_on: 1.month.from_now,
      } }
    end

    assert_redirected_to request_url(Request.last)
  end

  test 'should show request' do
    get request_url(@book_request)
    assert_response :success
  end

  test 'should get edit' do
    get edit_request_url(@book_request)
    assert_response :success
  end

  test 'should update request' do
    patch request_url(@book_request), params: { request: {
        returned_on: Date.today,
    } }

    assert_redirected_to request_url(@book_request)
  end

  test 'should destroy request' do
    assert_difference 'Request.count', -1 do
      delete request_url(@book_request)
    end

    assert_redirected_to requests_url
  end
end
