class AddDefaultValueToAmenities < ActiveRecord::Migration[5.0]
  def change
  	change_column :amenities, :pool, :boolean, default: false
  	change_column :amenities, :wifi, :boolean, default: false
  	change_column :amenities, :gym, :boolean, default: false
  	change_column :amenities, :kitchen, :boolean, default: false
  	change_column :amenities, :golf_course, :boolean, default: false
  	change_column :amenities, :tennis_court, :boolean, default: false
  end
end
