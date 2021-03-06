class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :username, :string
    add_column :users, :level, :float, default: 1.0
    add_column :users, :coins, :integer, default: 0
    add_column :users, :description, :string, default: "I'm a QuestBoard noob!"
    add_column :users, :lat, :float
    add_column :users, :lng, :float
  end
end
