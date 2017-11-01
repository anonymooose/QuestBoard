class AddCitycountryToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :citycountry, :string
  end
end
