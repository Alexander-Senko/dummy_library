class Request < ApplicationRecord
  belongs_to :book

  validates_presence_of :book, :borrower, :borrowed_on, :should_return_on
end
