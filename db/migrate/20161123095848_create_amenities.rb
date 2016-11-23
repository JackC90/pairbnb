class CreateAmenities < ActiveRecord::Migration[5.0]
  def change
    create_table :amenities do |t|
      t.boolean :pool
      t.boolean :wifi
      t.boolean :gym
      t.boolean :kitchen
      t.boolean :golf_course
      t.boolean :tennis_court
      t.references :listing, foreign_key: true

      t.timestamps
    end
  end
end
