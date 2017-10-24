class Event < ApplicationRecord
  belongs_to :game
  has_one :survey
  belongs_to :host
  has_many :players
  validates :game, :title, :address, :description, presence: true

  after_create :initialize_event
  before_update :ensure_gamesize

  def add_user(usr)
    if self.game.max_players < self.players.length && !attending?(usr)
      self.players << Player.create(user:usr,event:self)
      self.save
      return true
    end
    return false
  end

  def attending?(usr)
    self.players.each { |player| return true if player.user == usr }
    return false
  end

  private
  def initialize_event
    hostplayer = Player.create(user:self.host.user,event:self)
    self.players << hostplayer
  end

  def ensure_gamesize
    correct_players! unless valid_players?
  end

  def valid_players?
    self.players.length <= self.game.max_players ? true : false
  end

  def correct_players!
    self.players = []
    self.players.each { |player| self.players << player if self.players.length < self.game.max_players }
  end
end
