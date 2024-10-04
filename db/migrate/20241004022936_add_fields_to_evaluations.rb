class AddFieldsToEvaluations < ActiveRecord::Migration[7.2]
  def change
    add_column :evaluations, :start_date, :datetime unless column_exists?(:evaluations, :start_date)
    add_column :evaluations, :end_date, :datetime unless column_exists?(:evaluations, :end_date)
    add_column :evaluations, :instructions, :text unless column_exists?(:evaluations, :instructions)
  end
end