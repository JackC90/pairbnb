class AddColumnImagesToListings < ActiveRecord::Migration[5.0]
  def change
  	add_column :listings, :images, :string, :array => true, default: []
  end
end
