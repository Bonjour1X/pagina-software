class AddQuestionTypeToQuestions < ActiveRecord::Migration[7.2]
  def change
    add_column :questions, :question_type, :string
  end
end
