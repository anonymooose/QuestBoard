class Event < ApplicationRecord
  belongs_to :game
  has_one :survey
  belongs_to :host
  has_many :players
  validates :game, :title, :address, :description, presence: true
  before_validation :geocode_address, :on => :create


  after_create :initialize_event
  before_save :ensure_gamesize

  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng

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
    puts "WARNING! Semantic error. Event somehow has more players than allowed. resetting list to the first #{self.game.max_players}."
    self.players = []
    self.players.each { |player| self.players << player if self.players.length < self.game.max_players }
  end


  def geocode_address
    geo=Geokit::Geocoders::MultiGeocoder.geocode (address)
    errors.add(:address, "Could not Geocode address") if !geo.success
    self.lat, self.lng = geo.lat,geo.lng if geo.success
  end

end
