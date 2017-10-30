class Avatar < ApplicationRecord
  belongs_to :user
  validates :gender, :bottom, :top, :shoes, :hair, presence: true
  before_save :reset_avatar!, unless: :valid_items?

  private
  def reset_avatar!
    self.update(gender:0,shoes:0,top:0,bottom:0,hair:0)
  end

  def valid_items?
    binding.pry
    return false unless [0,1].include?(self.gender)
    return false unless [0,1].include?(self.shoes)
    return false unless (0..3).include?(self.top)
    return false unless (0..3).include?(self.bottom)
    return false unless (0..5).include?(self.hair)
    return true
  end
end
