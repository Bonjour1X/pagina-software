class AddTipoToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :tipo, :string
  end
end
