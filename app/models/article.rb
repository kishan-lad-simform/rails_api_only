class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  paginates_per 3
end
