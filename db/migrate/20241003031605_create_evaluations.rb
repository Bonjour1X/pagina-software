# Funcion creadora de Evaluaciones
class CreateEvaluations < ActiveRecord::Migration[7.2]
  def change
    create_table :evaluations do |t|
      t.string :name, null: false
      t.text :questions
      t.text :solution
      t.string :evaluation_method
      t.references :course, null: false, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.text :instructions

      t.timestamps
    end
  end
end