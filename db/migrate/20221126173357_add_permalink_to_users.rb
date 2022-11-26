class AddPermalinkToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :permalink, :string
  end
end
