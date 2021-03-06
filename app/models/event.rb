class Event < ApplicationRecord
  belongs_to :game
  belongs_to :host
  belongs_to :win, class_name: 'User', optional: true
  has_many :players, dependent: :destroy
  has_many :surveys, through: :players
  validates :game, :title, :address, :description, :datetime, presence: true
  before_validation :geocode_address, :on => :create


  after_create :initialize_event
  before_save :ensure_gamesize, :set_rewards

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
    if !already_distributed? && past?
      distribute_surveys!
      return self.reload.surveys
    else
      return self.surveys
    end
  end

  def past?
    self.datetime < Time.now ? true : false
  end

  def time=(val)
    @time = val
  end

  def time
    @time
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

  def set_rewards
    unless self.game.game_length == 0
      modifier = ((self.game.complexity)+((self.game.game_length)/15))
    else
      modifier = self.game.complexity
    end
    pre = 5.5*self.game.complexity*modifier*(((self.game.max_players)*0.1)/0.6)
    self.experience = pre.to_i
    pre = 1.5*self.game.max_players*modifier
    self.coins = pre.to_i
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
    self.citycountry = "#{geo.city}, #{geo.country}"
    self.lat, self.lng = geo.lat,geo.lng if geo.success
  end

end
