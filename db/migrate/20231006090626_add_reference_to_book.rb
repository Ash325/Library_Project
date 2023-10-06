class AddReferenceToBook < ActiveRecord::Migration[7.0]
  def change
    add_reference :books, :library, foreign_key: true
  end
end
