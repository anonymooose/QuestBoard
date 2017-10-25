class Event < ApplicationRecord
  belongs_to :game
  belongs_to :host
  has_many :players
  has_many :surveys, through: :players
  validates :game, :title, :address, :description, presence: true

  after_create :initialize_event
  before_save :ensure_gamesize

  def add_user(usr)
    if self.players.length < self.game.max_players && !attending?(usr)
      player = Player.create(user:usr,event:self)
      self.players << player
      self.save
      return true
    end
    return false
  end

  def attending?(usr)
    return true if self.players.include?(usr)
    return false
  end

  def past?
    if already_distributed?
      return true
    elsif self.datetime < Time.now
      distribute_surveys
      return true
    else
      return false
    end
  end

  private
  def initialize_event
    hostplayer = Player.create(user:self.host.user,event:self)
    self.players << hostplayer
  end

  def already_distributed?
    self.surveys != []
  end
  def distribute_surveys
    self.players.each { |player| player.survey = Survey.new }
  end

  def ensure_gamesize
    correct_players! unless valid_players?
  end

  def valid_players?
    self.players.length <= self.game.max_players ? true : false
  end

  def correct_players!
    puts "WARNING! Semantic error. Event somehow has more players than allowed. resetting list to the first #{self.game.max_players}."
    self.players = []
    self.players.each { |player| self.players << player if self.players.length < self.game.max_players }
  end
end
