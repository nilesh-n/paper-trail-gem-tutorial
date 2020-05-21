class Comment < ApplicationRecord
  has_paper_trail

  belongs_to :article
  has_many :notes, dependent: :destroy
end
