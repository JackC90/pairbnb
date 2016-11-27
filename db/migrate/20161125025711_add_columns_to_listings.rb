class AddColumnsToListings < ActiveRecord::Migration[5.0]
  def change
  	add_column :listings, :date_begin, :date
  	add_column :listings, :date_end, :date
  	add_column :listings, :place_type, :string
  	add_column :listings, :property_type, :string
  end
end
