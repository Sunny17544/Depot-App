class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.string :status
      t.float :anount
      t.string :chargeid
      t.references :checkout, null: false, foreign_key: true

      t.timestamps
    end
  end
end
