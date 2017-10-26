class Event < ApplicationRecord
  belongs_to :game
  belongs_to :host
  belongs_to :win, class_name: 'User'
  has_many :players
  has_many :surveys, through: :players
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
    return true if self.players.include?(usr)
    return false
  end

  def surveys!
    distribute_surveys! if !already_distributed? && past?
    return self.surveys
  end

  def past?
    self.datetime < Time.now ? true : false
  end

  private

  def initialize_event
    hostplayer = Player.create(user:self.host.user,event:self)
    self.players << hostplayer
  end

  def already_distributed?
    self.surveys != []
  end
  def distribute_surveys!
    self.players.each { |player| player.survey = Survey.new }
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


  def geocode_address
    geo=Geokit::Geocoders::MultiGeocoder.geocode (address)
    # remove all this VVV doexn't work
    if !geo.success
      errors.add(:address, "Could not Geocode address")
      self.lat = 0.0
      self.lng = 0.0
      #remove
    end
    self.lat, self.lng = geo.lat,geo.lng if geo.success
  end

end
