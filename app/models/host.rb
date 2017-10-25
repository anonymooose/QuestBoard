class Host < ApplicationRecord
  belongs_to :user
  has_many :events
  #our ENTIRE logic banks on the host's id == user's id, just to be safe
  after_create :ensure_same

  private
  def ensure_same
    self.user_id = self.id
  end
end
