class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :name
      t.string :author
      t.string :language
      t.date :publication_date
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
