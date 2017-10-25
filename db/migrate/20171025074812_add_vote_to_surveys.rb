class AddVoteToSurveys < ActiveRecord::Migration[5.0]
  def change
    add_column :surveys, :vote_id, :integer
    add_column :surveys, :attended, :boolean, default: false
  end
end
