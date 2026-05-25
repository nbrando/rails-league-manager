class CreateMatchResults < ActiveRecord::Migration[8.1]
  def change
    create_table :match_results do |t|
      t.references :match, null: false, foreign_key: true, index: { unique: true }
      t.integer :home_goals
      t.integer :home_behinds
      t.integer :away_goals
      t.integer :away_behinds

      t.timestamps
    end
  end
end
