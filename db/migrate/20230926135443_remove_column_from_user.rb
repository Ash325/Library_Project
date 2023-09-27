class RemoveColumnFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :f_name, :string
    remove_column :users, :l_name, :string
  end
end
