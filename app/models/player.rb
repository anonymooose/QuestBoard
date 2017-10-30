class Player < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_one :survey, dependent: :destroy

  def username
    self.user.username
  end
end
