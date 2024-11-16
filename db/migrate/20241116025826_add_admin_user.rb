class AddAdminUser < ActiveRecord::Migration[7.0]
  def up
    unless User.exists?(email: 'admin@admin.com')
      User.create!(
        email: 'admin@admin.com',
        password: '123456',
        name: 'Administrador',
        phone: '123456789',
        tipo: 'Profesor'
      )
    end
  end

  def down
    User.find_by(email: 'admin@admin.com')&.delete
  end
end