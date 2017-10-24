class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :surveys
  has_many :events
  has_one :host
  has_one :player
  after_create :initialize_host_and_player
  before_save :initialize_user

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
end
