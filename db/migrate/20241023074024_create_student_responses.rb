class CreateStudentResponses < ActiveRecord::Migration[7.2]
  def change
    create_table :student_responses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.text :content
      t.timestamps
    end
    
    # Índice único para evitar respuestas duplicadas
    add_index :student_responses, [:user_id, :question_id], unique: true
  end
end