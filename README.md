# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version 2.6.2
* Rails version 6.0.3

* System dependencies
Se instalo dependencias como webpacker,bootstrap-sass.

* Configuration
Se agrega el database.yml la conexión a mysql 
de la siguiente forma :
default: &default
  adapter: mysql2
  encoding: utf8
  pool: 5
  username: root
  password: Demo_pw9
  socket: /var/run/mysqld/mysqld.sock

development:
  <<: *default
  database: practica_ruby

production:
  <<: *default
  database: practica_ruby_production 

Haber instalador bundler install con todas las gemas

* Database creation
para crear la base de datos necesitamos crear 
rake db:create

* Database initialization
rake db:migrate

* How to run the test suite
-No tiene ningun seed para correr ya que son datos que se insertarán de un archivo.

* Services (job queues, cache servers, search engines, etc.)
Para correr el server 
** rails server **

* Deployment instructions
si deseas deployar el proyecto - corres el siguiente comando HEROKU
git add .
git commit -am "make it better"
git push heroku master

AHORA SI TIENES UN SERVER DEDICADO COMO DIGITAL OCEAN -
configuras tu ambiente y luego corres el siguiente comando.
rails s -e production


* 
