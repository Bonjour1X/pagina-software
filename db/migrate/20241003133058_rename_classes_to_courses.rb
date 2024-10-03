class RenameClassesToCourses < ActiveRecord::Migration[7.2]
  def change
    rename_table :clases, :courses
  end
end
