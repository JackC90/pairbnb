class AddTitleToListing < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :title, :string, :after => :location
  end
end
