class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.decimal :amount
      t.references :reservation, foreign_key: true
      t.string :token

      t.timestamps
    end
  end
end
