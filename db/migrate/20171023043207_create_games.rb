class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :max_players
      t.string :name
      t.float :complexity
      t.integer :game_length

      t.timestamps
    end
  end
end
