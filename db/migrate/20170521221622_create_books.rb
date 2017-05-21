class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string     :title,       null: false, index: true
      t.string     :author,      null: false, index: true
      t.date       :released_on, null: false
      t.references :category,    null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
