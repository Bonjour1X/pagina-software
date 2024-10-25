class CreateQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :questions do |t|
      t.text :content
      t.references :evaluation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
