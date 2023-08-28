class Review < ApplicationRecord
  belongs_to :list
  validates :comment, presence: true, length: { minimum: 6 }
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
