class RemoveAchieveableFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_reference :users, :achieveable, foreign_key: true
  end
end
