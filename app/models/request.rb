class Request < ApplicationRecord
  belongs_to :book

  validates_presence_of :book, :borrower, :borrowed_on, :should_return_on


  scope :active, -> {
    where returned_on: nil
  }

  scope :expired, -> (date = Date.today) {
    active
        .where 'should_return_on < ?', date
  }
end
