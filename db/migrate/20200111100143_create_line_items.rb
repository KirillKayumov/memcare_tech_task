class CreateLineItems < ActiveRecord::Migration[6.0]
  def change
    create_table :line_items do |t|
      t.string :name, null: false
      t.float :price, null: false

      t.belongs_to :order, foreign_key: true

      t.timestamps
    end
  end
end
