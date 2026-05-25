class CreateSeasons < ActiveRecord::Migration[8.1]
  def change
    create_table :seasons do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.string :status
      t.references :division, null: false, foreign_key: true

      t.timestamps
    end
  end
end
