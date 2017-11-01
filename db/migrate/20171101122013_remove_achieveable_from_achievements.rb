class RemoveAchieveableFromAchievements < ActiveRecord::Migration[5.0]
  def change
    remove_reference :achievements, :achieveable, foreign_key: true
  end
end
