class Book < ApplicationRecord
  belongs_to :category
  has_many   :requests

  validates_presence_of :title, :author, :released_on, :category
end
