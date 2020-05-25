class NoteImage < ApplicationRecord
  has_paper_trail

  belongs_to :note
  has_one_attached :image
end
