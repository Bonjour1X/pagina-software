class ChatsController < ApplicationController
  
  def foro
    @course = Course.find(params[:id]) # Encuentra el curso por su ID
    @chat = @course.chat # Obtén el chat asociado al curso
    @user = current_user
    @enrollment_request = EnrollmentRequest.find_by(course: @course, user: @user)
  
    if @chat.present?
      @messages = @chat.messages # Obtén todos los mensajes del chat
    else
      # Si no hay chat, crear uno nuevo para el curso
      @chat = Chat.create(course: @course)
      @messages = [] # Si es un chat nuevo, establece los mensajes como un array vacío
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Curso no encontrado'
  end

  def crear_mensaje
    @course = Course.find(params[:id])
    puts "Curso encontrado: #{@course.inspect}" # Log para debugging
    @chat = @course.chat
    puts "Chat encontrado: #{@chat.inspect}" # Log para debugging
  
    # Verifica que usuario tenga permiso para enviar mensajes, eso ya si no funciona pues lo sacas
    unless can_send_message?(@course)
      redirect_to foro_course_path(@course), alert: "No tienes permiso para enviar mensajes"
      return
    end

    # Inicializa @message y construye el mensaje
    @message = @chat.messages.build
    @message.user = current_user

    # Asegúrate de que estés utilizando el nombre de parámetro correcto
    @message.content = params[:content] 
  
    if @message.save
      redirect_to request.referrer || root_path, notice: "Mensaje enviado exitosamente"
    else
      redirect_to foro_course_path(@course), alert: "Error al enviar el mensaje: #{@message.errors.full_messages.join(', ')}"
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Curso no encontrado'
  end

  def show
    @chat = Chat.find(params[:id])
    @enrollment_request = EnrollmentRequest.find_by(course_id: @chat.course_id, user_id: current_user.id)
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Chat no encontrado'
  end

  private

  # Verifica si el usuario puede enviar mensajes en el curso
  def can_send_message?(course)
    return true if current_user == course.user # El profesor siempre puede enviar mensajes
    
    # Los estudiantes necesitan estar inscritos y aprobados
    enrollment_request = EnrollmentRequest.find_by(course: course, user: current_user)
    enrollment_request&.approved?
  end
end