class CreateUserRoles < ActiveRecord::Migration[8.1]
  def change
    create_table :user_roles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :role
      t.string :resource_type
      t.integer :resource_id

      t.timestamps
    end

    add_index :user_roles, [:user_id, :role, :resource_type, :resource_id], unique: true
  end
end
