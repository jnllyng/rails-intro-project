class Book < ApplicationRecord
  belongs_to :genre
  belongs_to :author
  has_many :reviews
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :published_year, presence: true
end