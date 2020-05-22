class Note < ApplicationRecord
  has_paper_trail

  belongs_to :comment
  has_many :note_images
end
