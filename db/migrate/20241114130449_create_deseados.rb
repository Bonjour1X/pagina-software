class CreateDeseados < ActiveRecord::Migration[7.2]
  def change
    create_table :deseados do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
