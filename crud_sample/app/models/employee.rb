class Employee < ApplicationRecord
  has_rich_text :notes
  has_many :posts, dependent: :destroy
end
