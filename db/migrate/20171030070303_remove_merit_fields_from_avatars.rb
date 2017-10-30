class RemoveMeritFieldsFromAvatars < ActiveRecord::Migration
  def self.up
    remove_column :avatars, :sash_id
    remove_column :avatars, :level
  end
end
