class Article < ApplicationRecord
  has_paper_trail

  has_many :comments, dependent: :destroy
end
