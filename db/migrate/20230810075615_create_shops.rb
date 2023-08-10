class CreateShops < ActiveRecord::Migration[7.0]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :street
      t.integer :zipcode
      t.string :city
      t.string :neighbourhood
      t.boolean :popup

      t.timestamps
    end
  end
end
