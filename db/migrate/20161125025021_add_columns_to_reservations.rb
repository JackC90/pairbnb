class AddColumnsToReservations < ActiveRecord::Migration[5.0]
  def change
  	add_column :reservations, :no_of_guests, :integer, :default => 1, :after => :date_out
  	add_column :reservations, :total_price, :decimal, :default => 0, :after => :date_out
  end
end
