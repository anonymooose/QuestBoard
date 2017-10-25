class Survey < ApplicationRecord
  belongs_to :player
  has_one :event, through: :player
  before_save :ensure_filled
  private
  def ensure_filled
    #TODO: after migration, add logic for ensuring a  survey has data before saving
  end
end
