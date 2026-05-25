class CreatePlayerRegistrations < ActiveRecord::Migration[8.1]
  def change
    create_table :player_registrations do |t|
      t.references :player, null: false, foreign_key: true
      t.references :team_season, null: false, foreign_key: true
      t.integer :jersey_number
      t.date :joined_on
      t.date :left_on

      t.timestamps
    end

    add_index :player_registrations, [:player_id, :team_season_id], unique: true
  end
end
