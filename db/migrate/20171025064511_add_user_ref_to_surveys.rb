class AddUserRefToSurveys < ActiveRecord::Migration[5.0]
  def change
    add_reference :surveys, :user, foreign_key: true
    add_column :surveys, :vote, :string
  end
end
