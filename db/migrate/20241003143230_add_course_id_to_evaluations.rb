class AddCourseIdToEvaluations < ActiveRecord::Migration[7.2]
  def change
    add_reference :evaluations, :course, foreign_key: true, null: false
  end
end