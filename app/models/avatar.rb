class Avatar < ApplicationRecord

  belongs_to :user
  validates :gender, :bottom, :top, :shoes, :hair, presence: true
  before_save :reset_avatar!, unless: :valid_items?
  GENDER_CHOICE = {0=>"Male", 1=>'Female'}
  HAIR_CHOICE = {0=>'Bald!', 1=>'Brown crew', 2=>'Blonde parted', 3=>'Black spiked', 4=>'Brown short', 5=>'Black ponytail', 6=>'Blonde curly'}
  TOP_CHOICE = {0=>'Nothing!', 1=>'Male red', 2=>'Male green', 3=>'Female red', 4=>'Female green'}
  BOTTOM_CHOICE = {0=>'Undies!', 1=>'Male pants', 2=>'Male shorts', 3=>'Female shorts', 4=>'Female pants'}
  SHOE_CHOICE = {0=>"Barefoot", 1=>"Men's shoes", 2=>"Women's shoes"}

  private
  def reset_avatar!
    self.update(gender:0,shoes:0,top:0,bottom:0,hair:0)
  end

  def valid_items?
    return false unless [0,1].include?(self.gender)
    return false unless [0,1].include?(self.shoes)
    return false unless (0..3).include?(self.top)
    return false unless (0..3).include?(self.bottom)
    return false unless (0..5).include?(self.hair)
    return true
  end
end
