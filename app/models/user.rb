class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :surveys
  has_many :events
  has_one :host
  has_one :player
  after_create :initialize_host_and_player
  before_save :initialize_user
  validates :username, presence: true

  private

  def initialize_host_and_player
    Host.create(user_id:self.id)
    Player.create(user_id:self.id)
  end

  def initialize_user
    self.level = 1.0
    self.wins = 0
    self.coins = 0
    self.description = "I'm a QuestBoard noob!"
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
      user_params[:username] = user_params["first_name"] + " " + user_params["last_name"]
      user.update(user_params)
    else
      user_params[:username] = user_params["first_name"] + " " + user_params["last_name"]
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user

    def username(params)

    end

  end

end


