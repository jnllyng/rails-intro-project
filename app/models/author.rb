class Author < ApplicationRecord
  has_many :books
  validates :name, presence: true
  validates :nationality, presence: true
end
