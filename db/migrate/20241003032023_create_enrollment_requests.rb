# Funcion en migracion de Enviar Solicitud
class CreateEnrollmentRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :enrollment_requests do |t|
      t.references :user, foreign_key: true, null: false
      t.references :course, foreign_key: true, null: false
      t.string :status, default: 'pending'
      t.timestamps
    end
  end
end