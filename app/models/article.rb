class Article < ApplicationRecord
  has_paper_trail

  has_many :comments, dependent: :destroy
  has_many :notes, through: :comments
  has_many :note_images, through: :notes
  has_one_attached :image

  def self.restore(id)
    transaction do
      latest_version = Article.new(id: id).versions.last

      if latest_version.event == 'destroy'
        article = latest_version.reify
        if article.save
          previous = latest_version.reify(has_many: true)
          previous.comments.each { |c| restore_association(c, latest_version.transaction_id) }
          previous.notes.each { |n| restore_association(n, latest_version.transaction_id) }
          previous_images = PaperTrail::Version.where(transaction_id: latest_version.transaction_id, item_type: 'NoteImage')
          previous_images.each { |ni| ni.reify.save }

          return article
        end
      end
    end
  end
end
