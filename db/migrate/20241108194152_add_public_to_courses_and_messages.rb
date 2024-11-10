class AddPublicToCoursesAndMessages < ActiveRecord::Migration[7.2]
  def change
    add_column :courses, :public, :boolean, default: false
    add_column :messages, :public, :boolean, default: false
  end
end