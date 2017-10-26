class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :surveys, through: :players
  has_one :host, dependent: :destroy
  has_many :players
  has_many :events, through: :players
  has_many :wins
  validates :username, presence: true, :uniqueness => {
    :case_sensitive => false
  }
  before_create :ensure_new
  after_create :initialize_host

  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng

  # def ip_address
  #   current_sign_in_ip
  # end

  # def geocode_ip
  #   geo = Geokit::Geocoders::MultiGeocoder.geocode(ip_address)
  #   errors.add(:address, "Could not Geocode address") if !geo.success
  #   self.lat, self.lng = geo.lat,geo.lng if geo.success
  # end

  def votes
    result = Survey.where(vote_id:self.id)
    result.nil? ? [] : result
  end

  def wins
    return Event.where(win_id:self.id)
  end

  def surveys!
    self.events.each do |event|
      event.surveys! if event.win == nil
    end
    return self.reload.surveys
  end


  private
  def ensure_new
    self.level = 1.0
    self.coins = 0
    self.description = "I'm a QuestBoard noob!"
  end

  def initialize_host
    Host.create(user_id:self.id)
  end



  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user_params[:username] = user.username
      user.update(user_params)
    else
      user_params[:username] = user_params["first_name"] + " " + user_params["last_name"]
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user
  end

  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_h).first
      end
  end

  def geocode_address
    geo=Geokit::Geocoders::MultiGeocoder.geocode (ip_address)
    errors.add(:address, "Could not Geocode address") if !geo.success
    self.lat, self.lng = geo.lat,geo.lng if geo.success
  end

end


