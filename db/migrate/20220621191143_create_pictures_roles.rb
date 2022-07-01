class CreatePicturesRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :pictures_roles do |t|
      t.references :picture, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
    add_index(:roles, :pic_name)
    add_index(:roles, [ :pic_name, :resource_type, :resource_id ])
    add_index(:pictures_roles, [ :picture_id, :role_id ])
  end
end
