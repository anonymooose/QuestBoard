class Survey < ApplicationRecord
  belongs_to :player
  has_one :event, through: :player
  after_update :disallow_editing

  def vote
    self.vote_id.nil? ? nil : Player.find(self.vote_id)
  end

  def vote=(player)
    self.vote_id = player.id
    valid_player?(player) ? self.save : false
  end

  private
  def valid_player?(player_instance)
    self.event.players.include?(player_instance)
  end

  def disallow_editing
    self.attended = true
  end
end
