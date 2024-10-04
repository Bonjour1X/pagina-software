class RenameClassIdToCourseIdInEnrollmentRequests < ActiveRecord::Migration[7.2]
  def change
    rename_column :enrollment_requests, :class_id, :course_id
  end
end
