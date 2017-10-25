class Game < ApplicationRecord
  has_many :events
  validates :name, presence: true
  before_create :ensure_valid

  def self.get_by_name(title)
    #must match case perfectly
    return Game.where(name:title.to_s)[0]
  end

  private
  def ensure_valid
    self.complexity = 0.0 if self.complexity == nil
    self.game_length = 0 if self.complexity == nil
    needs_maxsize if self.max_players == nil
  end

  def needs_maxsize?
    return true
  end
end
