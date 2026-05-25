class CreatePlayers < ActiveRecord::Migration[8.1]
  def change
    create_table :players do |t|
      t.references :user, foreign_key: true
      t.string :first_name, null: false
      t.string :last_name
      t.date :date_of_birth

      t.timestamps
    end
  end
end
