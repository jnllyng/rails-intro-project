class Review < ApplicationRecord
  belongs_to :book
  validates :reviewer_name, presence: true
  validates :body, presence: true
  validates :rating, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 5 }
end
