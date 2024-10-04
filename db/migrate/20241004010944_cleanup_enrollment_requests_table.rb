class CleanupEnrollmentRequestsTable < ActiveRecord::Migration[7.2]
  def change
    if column_exists?(:enrollment_requests, :class_id)
      remove_index :enrollment_requests, :class_id if index_exists?(:enrollment_requests, :class_id)
      remove_foreign_key :enrollment_requests, column: :class_id if foreign_key_exists?(:enrollment_requests, column: :class_id)
      remove_column :enrollment_requests, :class_id
    end

    unless index_exists?(:enrollment_requests, :course_id)
      add_index :enrollment_requests, :course_id
    end

    unless foreign_key_exists?(:enrollment_requests, :courses)
      add_foreign_key :enrollment_requests, :courses
    end
  end
end