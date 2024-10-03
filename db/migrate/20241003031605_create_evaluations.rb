# Funcion creadora de Evaluaciones
class CreateEvaluations < ActiveRecord::Migration[7.2]
  def change
    create_table :evaluations do |t|
      t.string :name, null: false
      t.text :questions
      t.text :solution
      t.string :evaluation_method
      t.references :class, foreign_key: true, null: false

      t.timestamps
    end
  end
end