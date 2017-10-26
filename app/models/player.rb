class Player < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_one :survey

  def username
    self.user.username
  end
end
