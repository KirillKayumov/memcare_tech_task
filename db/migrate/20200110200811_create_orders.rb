class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :customer_name, null: false
      t.float :value, null: false

      t.timestamps
    end
  end
end
