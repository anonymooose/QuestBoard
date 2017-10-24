class Game < ApplicationRecord
  has_many :events

  def self.get_by_name(title)
    #currently VERY CASE SENSITIVE
    return Game.where(name:title.to_s)[0]
  end
end
