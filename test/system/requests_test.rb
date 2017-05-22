require 'application_system_test_case'

class RequestsTest < ApplicationSystemTestCase
  test 'visiting the index' do
    visit requests_url

    assert_selector 'h1', text: 'Requests'
  end

  test 'librarian can see active requests' do
    visit requests_url(scope: 'active')

    assert_selector    '.borrower', text: requests(:smeagol).borrower
    assert_no_selector '.borrower', text: requests(:gandalf).borrower
  end

  test 'librarian can list people who are late to return the books' do
    travel_to Date.new(3017, 7, 1) do
      visit requests_url(scope: 'expired')

      assert_no_selector '.borrower', text: requests(:smeagol).borrower
      assert_no_selector '.borrower', text: requests(:gandalf).borrower
    end

    travel_to Date.new(3017, 8, 1) do
      visit requests_url(scope: 'expired')

      assert_no_selector '.borrower', text: requests(:smeagol).borrower
      assert_no_selector '.borrower', text: requests(:gandalf).borrower
    end

    travel_to Date.new(3017, 9, 1) do
      visit requests_url(scope: 'expired')

      assert_selector    '.borrower', text: requests(:smeagol).borrower
      assert_no_selector '.borrower', text: requests(:gandalf).borrower
    end

    travel_to Date.new(3019, 5, 1) do
      visit requests_url(scope: 'expired')

      assert_selector    '.borrower', text: requests(:smeagol).borrower
      assert_no_selector '.borrower', text: requests(:gandalf).borrower
    end
  end

  test 'librarian can submit a request' do
    visit books_path(title: books(:hobbit).title)

    click_on 'Request'

    fill_in 'Borrower',         with: 'The Tester'
    fill_in 'Borrowed on',      with: Date.today
    fill_in 'Should return on', with: 1.month.from_now

    click_on 'Create Request'

    assert_text 'Creating a Request'
  end

  test 'librarian can update a request' do
    # TODO
  end
end
