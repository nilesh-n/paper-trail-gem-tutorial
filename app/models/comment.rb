class Comment < ApplicationRecord
  has_paper_trail

  belongs_to :article
end
