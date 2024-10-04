class CleanupEnrollmentRequestsTable < ActiveRecord::Migration[7.2]
  def up
    # Elimina la columna class_id y su índice
    remove_index :enrollment_requests, :class_id if index_exists?(:enrollment_requests, :class_id)
    remove_foreign_key :enrollment_requests, column: :class_id if foreign_key_exists?(:enrollment_requests, column: :class_id)
    remove_column :enrollment_requests, :class_id

    # Asegúrate de que course_id tiene el índice y la clave foránea correcta
    unless index_exists?(:enrollment_requests, :course_id)
      add_index :enrollment_requests, :course_id
    end
    unless foreign_key_exists?(:enrollment_requests, :courses)
      add_foreign_key :enrollment_requests, :courses
    end
  end

  def down
    add_column :enrollment_requests, :class_id, :bigint
    add_index :enrollment_requests, :class_id
    add_foreign_key :enrollment_requests, :courses, column: :class_id
  end
end