class Event < ApplicationRecord
  has_one :game
  belongs_to :host
  has_many :players
end
