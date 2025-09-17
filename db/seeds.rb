puts "Limpiando la base de datos..."
Session.destroy_all
Transferencia.destroy_all
Articulo.destroy_all
User.destroy_all
Persona.destroy_all
Modelo.destroy_all
Marca.destroy_all

puts "Creando Usuario de Prueba..."
User.create!(
  email_address: 'test@example.com',
  password: 'password',
  password_confirmation: 'password'
)

puts "Creando Marcas y Modelos..."
apple = Marca.create!(nombre: "Apple")
samsung = Marca.create!(nombre: "Samsung")
dell = Marca.create!(nombre: "Dell")

Modelo.create!(marca: apple, nombre: "MacBook Pro 16")
Modelo.create!(marca: apple, nombre: "iPhone 15 Pro")
Modelo.create!(marca: samsung, nombre: "Galaxy S24 Ultra")
Modelo.create!(marca: dell, nombre: "XPS 15")
Modelo.create!(marca: dell, nombre: "Latitude 7420")

puts "Creando Personas y Artículos..."
juan = Persona.create!(nombre: "Juan", apellido: "Perez")
maria = Persona.create!(nombre: "Maria", apellido: "Gomez")
carlos = Persona.create!(nombre: "Carlos", apellido: "Rodriguez")

macbook = Articulo.create!(modelo: Modelo.find_by(nombre: "MacBook Pro 16"), fecha_ingreso: Date.today - 30, persona: juan)
Transferencia.create!(articulo: macbook, persona: juan)

iphone = Articulo.create!(modelo: Modelo.find_by(nombre: "iPhone 15 Pro"), fecha_ingreso: Date.today - 15, persona: juan)
Transferencia.create!(articulo: iphone, persona: juan)

galaxy = Articulo.create!(modelo: Modelo.find_by(nombre: "Galaxy S24 Ultra"), fecha_ingreso: Date.today - 5, persona: maria)
Transferencia.create!(articulo: galaxy, persona: maria)

dell_xps = Articulo.create!(
  modelo: Modelo.find_by(nombre: "XPS 15"), 
  fecha_ingreso: Date.today - 60,
  persona: carlos
)
Transferencia.create!(articulo: dell_xps, persona: carlos)

dell_latitude = Articulo.create!(
  modelo: Modelo.find_by(nombre: "Latitude 7420"), 
  fecha_ingreso: Date.today - 90,
  persona: carlos
)
Transferencia.create!(articulo: dell_latitude, persona: carlos)

puts "Realizando una transferencia de ejemplo..."
macbook.update!(persona: maria)
Transferencia.create!(articulo: macbook, persona: maria)

puts "Base de datos inicializada con datos de ejemplo."