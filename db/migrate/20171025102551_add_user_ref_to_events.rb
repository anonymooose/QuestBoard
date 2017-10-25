class CreateJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table (:events, :users, options: {}) do |t|
      t.index :event_id, name: {  }
    end
  end
end


Event <
...
.
.
.
win_id: equivalent user_id
(win_id:1 is User.find(1))


>

