class CreateAvatars < ActiveRecord::Migration[5.0]
  def change
    create_table :avatars do |t|
      t.references :user, foreign_key: true
      t.integer :gender, default: 0
      t.integer :bottom, default: 0
      t.integer :top, default: 0
      t.integer :hair, default: 0
      t.integer :shoes, default: 0

      t.timestamps
    end
  end
end
