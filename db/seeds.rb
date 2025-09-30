
puts "Limpiando la base de datos..."
Session.destroy_all
Transferencia.destroy_all
Articulo.destroy_all
User.destroy_all
Persona.destroy_all
Modelo.destroy_all
Marca.destroy_all
puts "Base de datos limpia."

puts "\n--- Creando Superadmin ---"

User.create!(
  email_address: 'superadmin@gmail.com',
  password: 'superpassword',
  password_confirmation: 'superpassword',
  admin: true
)
puts "Usuario Superadmin creado."

puts "\n--- Creando Marcas y Modelos ---"
apple = Marca.create!(nombre: "Apple")
samsung = Marca.create!(nombre: "Samsung")
dell = Marca.create!(nombre: "Dell")

Modelo.create!(marca: apple, nombre: "MacBook Pro 16")
Modelo.create!(marca: apple, nombre: "iPhone 15 Pro")
Modelo.create!(marca: samsung, nombre: "Galaxy S24 Ultra")
Modelo.create!(marca: dell, nombre: "XPS 15")
Modelo.create!(marca: dell, nombre: "Latitude 7420")
puts "Marcas y modelos creados."

puts "\n--- Creando Personas y sus Cuentas de Usuario (Usuarios Normales) ---"


juan = Persona.create!(nombre: "Juan", apellido: "Perez")
User.create!(
  email_address: 'juan.perez@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  persona: juan
)
puts "Creada Persona y User para Juan Perez."


maria = Persona.create!(nombre: "Maria", apellido: "Gomez")
User.create!(
  email_address: 'maria.gomez@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  persona: maria
)
puts "Creada Persona y User para Maria Gomez."

carlos = Persona.create!(nombre: "Carlos", apellido: "Rodriguez")
User.create!(
  email_address: 'carlos.r@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  persona: carlos
)
puts "Creada Persona y User para Carlos Rodriguez."

puts "\n--- Asignando Artículos ---"
macbook = Articulo.create!(modelo: Modelo.find_by(nombre: "MacBook Pro 16"), fecha_ingreso: Date.today - 30, persona: juan)
Transferencia.create!(articulo: macbook, persona: juan)

iphone = Articulo.create!(modelo: Modelo.find_by(nombre: "iPhone 15 Pro"), fecha_ingreso: Date.today - 15, persona: juan)
Transferencia.create!(articulo: iphone, persona: juan)

galaxy = Articulo.create!(modelo: Modelo.find_by(nombre: "Galaxy S24 Ultra"), fecha_ingreso: Date.today - 5, persona: carlos)
Transferencia.create!(articulo: galaxy, persona: carlos)
puts "Artículos asignados."

puts "\n--- Realizando una transferencia de ejemplo ---"
macbook.update!(persona: maria)
Transferencia.create!(articulo: macbook, persona: maria)
puts "Transferencia de MacBook a Maria Gomez completada."

puts "\nBase de datos inicializada con datos de ejemplo y roles conectados."
