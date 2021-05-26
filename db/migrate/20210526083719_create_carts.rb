class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.string :title
      t.decimal :price

      t.timestamps
    end
  end
end
