class AddFieldsToEvaluations < ActiveRecord::Migration[7.2]
  def change
    add_column :evaluations, :start_date, :datetime
    add_column :evaluations, :end_date, :datetime
    add_column :evaluations, :instructions, :text
  end
end
