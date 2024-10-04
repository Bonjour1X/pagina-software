# Funcion creadora de Evaluaciones
class CreateEvaluations < ActiveRecord::Migration[6.1]
  def change
    create_table :evaluations do |t|
      t.string :name
      t.string :evaluation_method
      t.datetime :start_date
      t.datetime :end_date
      t.text :instructions
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end