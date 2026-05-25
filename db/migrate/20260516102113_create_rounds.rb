class CreateRounds < ActiveRecord::Migration[8.1]
  def change
    create_table :rounds do |t|
      t.references :season, null: false, foreign_key: true
      t.integer :number, null: false
      t.date :start_date
      t.date :end_date

      t.timestamps
    end

    add_index :rounds, [:season_id, :number], unique: true
  end
end
