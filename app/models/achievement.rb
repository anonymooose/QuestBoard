class Achievement < ApplicationRecord
  belongs_to :achieveable, polymorphic: true
end
