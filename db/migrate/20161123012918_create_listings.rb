class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.text :address
      t.decimal :price
      t.string :location
      t.text :description
      t.boolean :availability
      t.integer :max_occupants
      t.integer :no_of_bedrooms
      t.integer :no_of_bathrooms
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
