class RemoveClassIdFromEvaluations < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :evaluations, :courses, column: :class_id, if_exists: true
    remove_index :evaluations, :class_id, if_exists: true
    remove_column :evaluations, :class_id
  end
end
