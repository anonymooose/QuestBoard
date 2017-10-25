class AddUserRefToSurveys < ActiveRecord::Migration[5.0]
  def change
    add_column :surveys, :vote, :string
  end
end
