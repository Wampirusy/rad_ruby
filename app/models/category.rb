class Category < ApplicationRecord
  validates :alias, uniqueness: true
end
