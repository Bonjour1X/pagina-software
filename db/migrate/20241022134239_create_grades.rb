class CreateGrades < ActiveRecord::Migration[7.0]
  def change
    create_table :grades do |t|
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.references :evaluation, null: false, foreign_key: true
      t.decimal :score, precision: 3, scale: 1

      t.timestamps
    end
    
    add_index :grades, [:student_id, :evaluation_id], unique: true
  end
end