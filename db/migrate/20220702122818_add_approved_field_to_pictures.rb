class AddApprovedFieldToPictures < ActiveRecord::Migration[7.0]
  def change
    add_column :pictures, :approved, :boolean, default: false
  end
end
