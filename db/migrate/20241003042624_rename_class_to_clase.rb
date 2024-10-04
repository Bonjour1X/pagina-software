class RenameClassToClase < ActiveRecord::Migration[7.2]
  def change
    rename_table :classes, :clases
  end
end
