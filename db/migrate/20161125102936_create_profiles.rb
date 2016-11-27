class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :location
      t.string :country
      t.text :description
      t.string :gender
      t.date :birthdate
      t.string :phone
      t.string :email
      t.string :language
      t.string :currency
      t.string :school
      t.string :work
      t.string :address
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
