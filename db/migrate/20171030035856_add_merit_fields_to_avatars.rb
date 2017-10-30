class AddMeritFieldsToAvatars < ActiveRecord::Migration
  def change
    add_column :avatars, :sash_id, :integer
    add_column :avatars, :level,   :integer, :default => 0
  end
end
