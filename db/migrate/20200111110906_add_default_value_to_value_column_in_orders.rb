class AddDefaultValueToValueColumnInOrders < ActiveRecord::Migration[6.0]
  def change
    change_column_default :orders, :value, from: nil, to: 0
  end
end
