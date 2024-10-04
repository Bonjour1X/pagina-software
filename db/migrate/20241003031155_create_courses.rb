# Clase de funcion creada para la creacion de clases en migracion
class CreateCourses < ActiveRecord::Migration[7.2]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.text :description
      t.datetime :scheduled_date
      t.text :materials
      t.string :modality
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end