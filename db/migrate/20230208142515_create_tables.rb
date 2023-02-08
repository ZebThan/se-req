class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table :merchants do |t|
      t.string :name
      t.string :email
      t.string :cif
      t.timestamps
    end

    create_table :shoppers do |t|
      t.string :name
      t.string :email
      t.string :nif

      t.timestamps
    end

    create_table :orders do |t|
      t.integer :merchant_id
      t.bigint :amount
      t.bigint :fee
      t.datetime :completed_at

      t.timestamps
    end

    create_table :payouts do |t|
      t.integer :merchant_id
      t.bigint :value
      t.integer :for_week
      t.integer :for_year

      t.timestamps
    end
  end
end
