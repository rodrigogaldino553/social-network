class RenameUserDescriptionToUserStatus < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :description, :status
  end
end
