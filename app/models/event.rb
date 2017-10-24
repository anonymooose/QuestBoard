class Event < ApplicationRecord
  belongs_to :game
  has_one :survey
  belongs_to :host
  has_many :players

  after_create :initialize_event

  private
  def initialize_event
    hostplayer = Player.create(user_id:self.host.user,event:self)
    event.players << hostplayer
  end
end
