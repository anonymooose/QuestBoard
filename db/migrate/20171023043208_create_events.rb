class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :description
      t.datetime :datetime
      t.string :title
      t.string :winner
      t.string :address
      t.integer :coins
      t.integer :experience
      t.references :game, foreign_key: true
      t.references :host, foreign_key: true
      t.float :lat
      t.float :lng
      t.timestamps
    end
  end
end
