class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.restore_association(association, transaction_id)
    association.versions.where(transaction_id: transaction_id).last.reify.save
  end
end
