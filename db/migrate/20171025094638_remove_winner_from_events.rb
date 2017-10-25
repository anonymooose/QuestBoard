class RemoveWinnerFromEvents < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :winner
  end
end
