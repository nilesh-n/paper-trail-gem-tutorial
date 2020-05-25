class Note < ApplicationRecord
  has_paper_trail

  belongs_to :comment
  has_many :note_images

  before_destroy do
    # note_images.update_all(note_id: nil)
    note_images.each { |note_image| note_image.update(note_id: nil) }
  end
end
