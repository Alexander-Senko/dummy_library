class Book < ApplicationRecord
  belongs_to :category
  has_many   :requests
  has_one    :current_request, -> { active }, class_name: 'Request'

  delegate :borrower, to: :current_request, allow_nil: true

  validates_presence_of :title, :author, :released_on, :category


  scope :available, -> {
    where.not id: borrowed # TODO: get rid of the subquery
  }

  scope :borrowed, -> {
    joins(:requests)
        .merge Request.active
  }

  scope :delayed, -> (date = Date.today) {
    joins(:requests)
        .merge Request.expired(date)
  }
end
