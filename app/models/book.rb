class Book < ApplicationRecord
  belongs_to :category
  has_many   :requests

  validates_presence_of :title, :author, :released_on, :category


  scope :available, -> {
    where.not id: borrowed # TODO: get rid of the subquery
  }

  scope :borrowed, -> {
    joins(:requests).where(requests: { returned_on: nil })
  }

  scope :delayed, -> {
    joins(:requests).where('requests.should_return_on < ?', Date.today)
  }
end
