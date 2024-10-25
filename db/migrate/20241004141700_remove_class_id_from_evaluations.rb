class RemoveClassIdFromEvaluations < ActiveRecord::Migration[6.1]
  def change
    if column_exists?(:evaluations, :class_id)
      remove_foreign_key :evaluations, :courses, column: :class_id, if_exists: true
      remove_index :evaluations, :class_id, if_exists: true
      remove_column :evaluations, :class_id
    end
  end
end