class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :username, :string
    add_column :users, :level, :float
    add_column :users, :wins, :integer
    add_column :users, :coins, :integer
    add_column :users, :description, :string
  end
end
