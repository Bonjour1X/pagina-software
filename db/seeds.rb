# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Crea admins con poderes de profesor 
admin_email = 'admin@admin.com'

unless User.exists?(email: admin_email) # crear esto y no guardarlo antes del merge dió problemas
  User.create!(
    email: admin_email,
    password: '123456',
    name: 'Administrador',
    phone: '123456789',
    tipo: 'Profesor'
  )
end