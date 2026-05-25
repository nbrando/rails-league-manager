class CreateTeamSeasons < ActiveRecord::Migration[8.1]
  def change
    create_table :team_seasons do |t|
      t.references :team, null: false, foreign_key: true
      t.references :season, null: false, foreign_key: true

      t.timestamps
    end

    add_index :team_seasons, [:team_id, :season_id], unique: true
  end
end
