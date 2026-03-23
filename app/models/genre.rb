class Genre < ApplicationRecord
  has_many :books
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
