class CreateDivisions < ActiveRecord::Migration[8.1]
  def change
    create_table :divisions do |t|
      t.string :name
      t.references :league, null: false, foreign_key: true

      t.timestamps
    end
  end
end
