class AddAttributesToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :phone, :string
    add_column :users, :description, :string
    add_column :users, :name, :string
  end
end
