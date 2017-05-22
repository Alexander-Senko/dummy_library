class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.references :book,             null: false, index: true, foreign_key: true
      t.string     :borrower,         null: false, index: true
      t.date       :borrowed_on,      null: false, index: true
      t.date       :should_return_on, null: false, index: true
      t.date       :returned_on,                   index: true

      t.timestamps
    end
  end
end
