class CreateVenues < ActiveRecord::Migration[8.1]
  def change
    create_table :venues do |t|
      t.string :venue_name, null: false
      t.string :address
      t.decimal :lat
      t.decimal :lng

      t.timestamps
    end
  end
end
