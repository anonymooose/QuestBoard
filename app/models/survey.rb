
class Survey < ApplicationRecord
  belongs_to :player
  has_one :event, through: :player
  before_update :disallow_editing
  after_update :set_winner_if_needed

  def vote
    self.vote_id.nil? ? nil : Player.find(self.vote_id)
  end

  def vote=(player)
    if player == 0
      self.destroy
    else
      self.vote_id = player.id
      valid_player?(player) ? self.save : false
      disallow_editing
    end
  end

  private
  def valid_player?(player_instance)
    self.event.players.include?(player_instance)
  end

  def disallow_editing
    self.attended = true
  end

  def set_winner_if_needed
    #event = self.event
    votes = self.event.surveys.where.not(vote_id:nil)
    count = votes.pluck(:vote_id).group_by(&:itself).max_by{|_,v|v.size}.first
  end
end
