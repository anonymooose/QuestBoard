class Badgelist < ApplicationRecord
  belongs_to :user
  belongs_to :achievement
end
