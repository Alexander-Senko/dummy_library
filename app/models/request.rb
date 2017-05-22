class Request < ApplicationRecord
  belongs_to :book
  has_many   :active_requests,  -> { active  }, class_name: 'Request', foreign_key: :borrower, primary_key: :borrower
  has_many   :expired_requests, -> { expired }, class_name: 'Request', foreign_key: :borrower, primary_key: :borrower

  validates_presence_of :book, :borrower, :borrowed_on, :should_return_on
  validates_absence_of  :active_requests, on: :create


  scope :active, -> {
    where returned_on: nil
  }

  scope :expired, -> (date = Date.today) {
    active
        .where 'should_return_on < ?', date
  }
end
