#  README
#  Sprint_3
 #  Aplicación Ruby on Rails - Grupo 23

Puedes acceder a la aplicación en el siguiente enlace:

[Aplicación en Render](https://two024-2-grupo-23.onrender.com)

- **Para entrar como administrador: tenemos que usar como correo: admin@admin.com , contraseña: 123456

- **El Administrado puede, crear,editar,eliminar todos los cursos, tambien es el unico que puede eliminar los mensajes del foro/chat
  
## Descripción

Aplicación web desarrollada en Ruby on Rails para la gestión de cursos en línea y evaluaciones interactivas. La plataforma permite a los usuarios:

- **Registrarse y explorar cursos**: Los visitantes pueden ver información sobre los cursos ofrecidos y acceder a reseñas.
- **Inscribirse en cursos**: Los estudiantes pueden solicitar su inclusión en cursos específicos y acceder a contenido educativo.
- **Participar en evaluaciones**: Los usuarios aceptados en un curso pueden realizar evaluaciones y acceder a material adicional.
- **Gestionar el progreso**: Los profesores pueden crear y gestionar evaluaciones, monitorear el progreso de los estudiantes y recibir reseñas al finalizar los cursos.

La aplicación facilita un entorno de aprendizaje interactivo y eficiente tanto para estudiantes como para profesores.

### Características Generales
- **Visita de Información:** Los visitantes pueden ver información sobre el sitio y su funcionamiento, incluyendo un menú con los cursos ofrecidos. Pueden acceder a la información de estos cursos. También pueden consultar reseñas de otros alumnos.
- **Registro y Perfil:** Una vez registrado e iniciado sesión, el usuario puede subir una foto e información personal. 
- **Solicitud de Cursos:** Los usuarios pueden enviar solicitudes para integrarse a uno o varios cursos ofrecidos simultáneamente. Estas solicitudes pueden ser aceptadas o rechazadas por los profesores de los cursos.
- **Acceso a Evaluaciones y Material:** Una vez aceptada la solicitud, el usuario puede realizar las evaluaciones, conversar con otros participantes del curso, y acceder a material y videos de enseñanza.
- **Reseñas:** Al cursar el curso, los usuarios tienen la opción de dejar una reseña evaluando tanto el curso como a los profesores involucrados, proporcionando información adicional a futuros usuarios.
  
## Información del Proyecto (sprint2)
Hasta ahora un visitante puede crear una cuenta, logearse a ella, cambiar sus datos y eliminarla.
Un usuario registrado puede ver las clases ofrecidas (uno no registrado también) y enviar una solicitud a alguna de ellas, además puede ver las clases de las cuales forma parte.
Por otro lado un profesor puede crear una clase, manejar las solicitudes de su clase y eliminar su clase.
Además un usuario puede hacer reseñas en los cursos a los cuales pertenece.
Por otro lado, cada curso tiene un foro, donde solo pueden participar integrantes del curso 
y el profesor.
Además el profesor material en forma de archivos (recomendado en PDF), subiendo, reemplazando o 
eliminando archivos. Los alumnos incritos al curso pueden ver estos archivos.
También se usó bulma para mejorar la interfaz gráfica. 

## Información del Proyecto (sprint3)
Se creó un admin
Mejoras en el frontend
Archivos solo permite pdf
Se añadió la foto de perfil (revisar en ajustes -> mi perfil)

### Ruby version

- Ruby 3.1.0

### Dependencias del Sistema

- Rails 7.x.x
- Bundler
- Cloudinary
- ActiveStorage
- Usa weatherapi

### Configuración

El archivo de configuración para RuboCop está incluido en el proyecto para mantener el código conforme a las mejores prácticas.

