
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

  def host_win=(player)
    self.event.win = (player.user) if self.event.win == nil
    self.vote=(player)
  end

  def host_attendance=(player)
    self.event.win = (player.user)
  end

  def host_attendance
    self.event.players
  end

  def host_win
    winner = self.event.win.id unless self.event.win.nil?
    winner.nil? ? nil : self.event.players.where('user_id = ?', self.event.win.id)
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
      votes = results.pluck(:vote_id)
      #[1,1,1,1,2,3,4,5,5,5,...]
      counter = votes.group_by(&:itself).max_by{|_,v|v.size}
      # [id, [id,id,id,...]]
      if counter != nil
        if counter.last.length > (self.game.players.count)/2
          self.event.win = Player.find(counter.first).user
          self.event.save
          return true
        end
      end
    end
    return false
  end
end
