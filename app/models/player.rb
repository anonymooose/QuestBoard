class Player < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_one :survey

  def is_event_past?
    if already_distributed?
      return true
    elsif self.event.datetime < Time.now
      distribute_surveys
      return true
    else
      return false
    end
  end
  private
  def already_distributed?
    self.survey != nil
  end
  def distribute_surveys
    self.event.players.each { |player| player.survey = Survey.new }
  end
end
