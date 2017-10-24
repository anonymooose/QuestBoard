class Host < ApplicationRecord
  belongs_to :user
  has_many :events

  def self.get_by_username(str)
    return User.where(username:str.to_s)[0].host
  end
end
