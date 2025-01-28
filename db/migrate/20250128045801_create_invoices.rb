class CreateInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :invoices do |t|
      t.string :product
      t.decimal :price
      t.integer :quantity
      t.decimal :total

      t.timestamps
    end
  end
end
