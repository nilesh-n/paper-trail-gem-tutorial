class NoteImage < ApplicationRecord
  belongs_to :note
  has_one_attached :image
end
