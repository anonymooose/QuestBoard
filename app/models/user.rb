class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :surveys
  has_one :host, dependent: :destroy
  has_many :players
  after_create :initialize_host, :initialize_user
  before_save :initialize_user

  private
  def initialize_host
    Host.create(user_id:self.id)
  end
  def initialize_user
    self.level = 1.0
    self.wins = 0
    self.coins = 0
    self.description = "I'm a QuestBoard noob!"
  end
end
