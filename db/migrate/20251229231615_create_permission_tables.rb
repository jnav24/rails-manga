class CreatePermissionTables < ActiveRecord::Migration[8.1]
  def change
    create_table :permissions do |t|
      t.string :name, null: false
      t.string :guard_name, default: "web"
      t.timestamps
      t.index [:name, :guard_name], unique: true
    end

    create_table :roles do |t|
      t.string :name, null: false
      t.string :guard_name, default: "web"
      t.timestamps
      t.index [:name, :guard_name], unique: true
    end

    create_table :role_has_permissions do |t|
      t.references :role, null: false, foreign_key: true
      t.references :permission, null: false, foreign_key: true
      t.timestamps

      t.index [:role_id, :permission_id], unique: true, name: 'index_role_has_permissions_on_role_and_permission'
    end

    create_table :model_has_permissions do |t|
      t.references :permission, null: false, foreign_key: true
      t.references :model, polymorphic: true, null: false, index: false
      t.timestamps

      t.index [:permission_id, :model_type, :model_id],
              unique: true,
              name: 'index_model_has_permissions_on_permission_and_model'
      t.index [:model_type, :model_id]
    end

    create_table :model_has_roles do |t|
      t.references :role, null: false, foreign_key: true
      t.references :model, polymorphic: true, null: false, index: false
      t.timestamps

      t.index [:role_id, :model_type, :model_id],
              unique: true,
              name: 'index_model_has_roles_on_role_and_model'
      t.index [:model_type, :model_id]
    end
  end
end
