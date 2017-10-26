
class Survey < ApplicationRecord
  belongs_to :player
  has_one :game, through: :event
  has_one :event, through: :player
  has_one :user, through: :player
  after_update :set_winner_if_needed

  def vote
    self.vote_id.nil? ? nil : Player.find(self.vote_id)
  end

  def vote=(player)
    if player == 0 && self.attended == false
      self.destroy
      return nil
    elsif self.attended == false
      self.vote_id = player.id
      disallow_editing
      valid_player?(player) ? self.save : false
      return true
    end
    return false
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
    results = self.event.surveys.where.not(vote_id:nil)
    if results != nil
      #[1,1,1,1,2,3,4,5,5,5,...]
      votes = results.pluck(:vote_id)
      # [id, [id,id,id,...]]
      counter = votes.group_by(&:itself).max_by{|_,v|v.size}
      if counter != nil
        if counter.last.length > (self.game.max_players)/2
          self.event.win = Player.find(counter.first).user
          self.event.save
          return true
        end
      end
    end
    return false
  end
end
