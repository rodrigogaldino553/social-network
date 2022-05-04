class CreatePictures < ActiveRecord::Migration[7.0]
  def change
    create_table :pictures do |t|
      t.text :legend

      t.timestamps
    end
  end
end
